//
//  AuthViewController.swift
//  Augment
//
//  Created by Rohan Mishra on 10/7/17.
//  Copyright © 2017 Augment. All rights reserved.
//

import UIKit
import Alamofire
import OAuthSwift

class AuthViewController: UIViewController {
    
    let api = API()
    let constants = Constants()
    
    @IBAction func logInAction(_ sender: Any) {
        api.authenticateWithView(viewController: self)
    }
    
    @IBAction func triggerRequest(_ sender: Any) {
        api.postToServer()
    }
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
