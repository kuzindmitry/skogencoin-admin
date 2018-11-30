//
//  APIClient.swift
//  SkogenCoinAdmin
//
//  Created by Dmitry Kuzin on 29/11/2018.
//  Copyright © 2018 SkogenCoin. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    static let shared = APIClient()
    
    let adminID = "5bffd69d2597825598421ee8"
    let urlString: String = "https://radiant-forest-47611.herokuapp.com/api/"
    var url: URL {
        if let url = URL(string: urlString) {
            return url
        }
        fatalError()
    }
    
    fileprivate var authorizationHeader: [String : String] {
        if let token = ProfileDatabaseManager().getProfile()?.token {
            return ["Authorization" : "Bearer \(token)"]
        }
        return [:]
    }
    
}

// Authorization

extension APIClient {
    
    func login(_ model: RequestLoginModel, _ completion: @escaping (Bool) -> Void) {
        let url = self.url.appendingPathComponent("login")
        NetworkManager.shared.post(url, data: model.jsonData, headers: ["Content-Type": "application/json"]) { (data, success) in
            guard let data = data, success, let loginModel = (try? JSONDecoder().decode(LoginModel.self, from: data)) else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            guard loginModel._id == self.adminID else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            let database = ProfileDatabaseManager()
            database.loginProfile(loginModel)
            DispatchQueue.main.async {
                completion(true)
            }
        }
    }
    
}


extension APIClient {
    
    func orders(_ completion: @escaping ([Order]) -> Void) {
        let url = self.url.appendingPathComponent("order")
        NetworkManager.shared.get(url, headers: authorizationHeader) { (data, success) in
            guard let data = data, let items = (try? JSONDecoder().decode([Order].self, from: data)), success else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            completion(items.sorted { $0.createdDate > $1.createdDate })
        }
    }
    
}

extension APIClient {
    
    func registerPush(_ model: PushSettings, _ completion: @escaping () -> Void) {
        let url = self.url.appendingPathComponent("push")
        var headers = ["Content-Type": "application/json"]
        for (key, value) in authorizationHeader {
            headers[key] = value
        }
        NetworkManager.shared.post(url, data: model.jsonData, headers: headers) { (data, success) in
        }
    }
    
}
