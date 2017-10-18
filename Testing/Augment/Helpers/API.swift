//
//  API.swift
//  Augment
//
//  Created by Rohan Mishra on 10/7/17.
//  Copyright © 2017 Augment. All rights reserved.
//

import Alamofire
import OAuthSwift
import Foundation
import SwiftyJSON
import CoreData

class API {

    let constants = Constants()
    var user: [NSManagedObject] = []
    
    /*
     Create New User
     - Make auth call w/ OAuth2Swift
     */
    func authenticateWithView(viewController: UIViewController) {
        var oauthswift: OAuth2Swift!
        oauthswift = OAuth2Swift(
            consumerKey:    constants.CLIENT_ID,
            consumerSecret: constants.CLIENT_SECRET,
            authorizeUrl:   "https://api.lyft.com/oauth/authorize",
            accessTokenUrl: "https://api.lyft.com/oauth/token",
            responseType:   "code",
            contentType:    "application/json"
        )
        
        oauthswift.accessTokenBasicAuthentification = true
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: oauthswift)
        
        let state = generateState(withLength: 20)
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: "augment://oauth-callback/lift")!, scope: "public rides.read offline rides.request profile", state: state,
            success: { credential, response, parameters in
                print(credential.oauthToken)
                
                self.createNewUser(oauthtoken: credential.oauthToken)
            },
            failure: { error in
                print(error.description)
            }
        )
    }
    
    /*
     createNewUser(oauthtoken: String)
     - Make request to lyft: /profile
     - Create new Realm user w/ id, first_name, last_name, access_token
     - Make request to server
    */
    func createNewUser(oauthtoken: String) {
        // headers
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + oauthtoken
        ]
        
        // get user info w/ access token
        Alamofire.request(self.constants.LYFT_URL + "/profile", headers: headers).responseJSON { response in
            if response.error == nil {
                // save user to Core data
                let data = JSON(response.data!)
                let context = self.getContext()
                
                let entity =  NSEntityDescription.entity(forEntityName: "User", in: context)
                let transc = NSManagedObject(entity: entity!, insertInto: context)
                
                transc.setValue(data["id"].stringValue, forKey: "lyft_id")
                transc.setValue(oauthtoken, forKey: "lyft_access_token")
                
                do {
                    try context.save()
                    print("saved!")
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                } catch {
                    print("wtf")
                }
            } else {
                print(response.error!)
            }
        }
    }
    
    func getContext () -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = delegate.persistentContainer.viewContext
        return managedObjectContext
    }
    
    func postToServer() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //You need to convert to NSManagedObject to use 'for' loops
            for person in searchResults as [NSManagedObject] {
                let lyft_id = person.value(forKey: "lyft_id")
                let access_token = person.value(forKey: "lyft_access_token")
                
                let parameters: Parameters = [
                    "id": lyft_id!,
                    "access_token": access_token!,
                    "email": "look whats up brian lollol"
                ]
                
                print(parameters)
                
                Alamofire.request(self.constants.AUGMENT_SERVER + "/new/user", method: .post, parameters: parameters).responseJSON { response in
                    if response.error == nil {
                        print(response)
                    } else {
                        print(response.error!)
                    }
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
}
