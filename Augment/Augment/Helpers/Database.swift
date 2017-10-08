//
//  Model.swift
//  Augment
//
//  Created by Rohan Mishra on 10/7/17.
//  Copyright © 2017 Augment. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var id = ""
    @objc dynamic var access_token = ""
}
