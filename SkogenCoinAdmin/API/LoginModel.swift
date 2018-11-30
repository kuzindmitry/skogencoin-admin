//
//  LoginModel.swift
//  SkogenCoin
//
//  Created by Dmitry Kuzin on 22/11/2018.
//  Copyright © 2018 Stanislau Sakharchuk. All rights reserved.
//

import Foundation

class RequestLoginModel: Codable {
    var phone: String = ""
    var password: String = ""
    
    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }
}

class LoginModel: Decodable {
    let _id: String
    let name: String?
    let surname: String?
    let phone: String
    let email: String?
    let password: String
    let token: String?
    let stripeId: String?
    let createTime: String?
    let photo: String?
}
