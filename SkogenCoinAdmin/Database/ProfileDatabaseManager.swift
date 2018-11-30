//
//  ProfileDatabaseManager.swift
//  SkogenCoin
//
//  Created by Evgeny Mahnach on 10/20/18.
//  Copyright © 2018 Evgeny Mahnach. All rights reserved.
//

import RealmSwift

class ProfileDatabaseManager {
    
    let realm = try! Realm()
    
    func getProfile() -> Profile? {
        return realm.objects(Profile.self).first
    }
    
    func saveProfile(profile: Profile) {
        try! realm.write {
            realm.delete(realm.objects(Profile.self))
            realm.add(profile)
        }
    }
    
    func loginProfile(_ model: LoginModel) {
        let profile = Profile()
        profile.id = model._id
        profile.name = model.name
        profile.surname = model.surname
        profile.phoneNumber = model.phone
        profile.code = model.password
        profile.email = model.email
        profile.createdTime = model.createTime
        profile.token = model.token
        profile.stripeId = model.stripeId
        profile.photo = model.photo
        saveProfile(profile: profile)
    }
    
    func deleteProfile() {
        try! realm.write {
            realm.delete(realm.objects(Profile.self))
        }
    }
    
    func editProfile(with name: String? = nil, surname: String? = nil, email: String? = nil, phoneNumber: String? = nil, avatar: Data? = nil, code: String? = nil) {
        guard let profile = getProfile() else { return }
        try! realm.write {
            profile.name = name != nil ? name : profile.name
            profile.surname = surname != nil ? surname : profile.surname
            profile.email = email != nil ? email : profile.email
            profile.phoneNumber = phoneNumber != nil ? phoneNumber : profile.phoneNumber
            profile.avatar = avatar != nil ? avatar : profile.avatar
            profile.code = code != nil ? code : profile.code
        }
    }
    
}
