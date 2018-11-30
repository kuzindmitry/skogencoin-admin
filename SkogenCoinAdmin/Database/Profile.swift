//
//  Profile.swift
//  SkogenCoin
//
//  Created by Evgeny Mahnach on 10/18/18.
//  Copyright © 2018 Evgeny Mahnach. All rights reserved.
//

import RealmSwift

class Profile: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String?
    @objc dynamic var surname: String?
    @objc dynamic var phoneNumber: String?
    @objc dynamic var email: String?
    @objc dynamic var createdTime: String?
    @objc dynamic var token: String?
    @objc dynamic var avatar: Data?
    @objc dynamic var photo: String?
    @objc dynamic var code: String?
    @objc dynamic var stripeId: String?
    
}
