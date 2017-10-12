//
//  Models.swift
//  Augment
//
//  Created by Rohan Mishra on 10/11/17.
//  Copyright © 2017 Augment. All rights reserved.
//

import Foundation
import RealmSwift

class Rider: Object {
    @objc dynamic var lyftID           = ""
    @objc dynamic var userID           = ""
    @objc dynamic var userFirstName    = ""
    @objc dynamic var userLastName     = ""
    
    @objc dynamic var lyftAccessToken  = ""
    @objc dynamic var uberAccessToken  = ""

    var name: String {
        return "\(user_first_name) \(user_last_name)"
    }
}

class Driver: User {
    
}

