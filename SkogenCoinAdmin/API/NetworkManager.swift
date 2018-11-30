//
//  NetworkManager.swift
//  SkogenCoin
//
//  Created by Dmitry Kuzin on 22/11/2018.
//  Copyright © 2018 Stanislau Sakharchuk. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    typealias NetworkManagerResponse = (Data?, Bool) -> Void
    
    func get(_ url: URL, headers: [String : String]? = nil, _ completion: @escaping NetworkManagerResponse) {
        logRequest(url, method: "GET", data: nil, headers: headers)
        var request = URLRequest(url: url)
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, false)
                return
            }
            print(String(data: data, encoding: .utf8)!)
            completion(data, true)
        }.resume()
    }
    
    func post(_ url: URL, data: Data?, headers: [String : String]? = nil, _ completion: @escaping NetworkManagerResponse) {
        var request = URLRequest(url: url)
        request.httpBody = data
        request.httpMethod = "POST"
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        logRequest(url, method: "POST", data: data, headers: headers)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, false)
                return
            }
            print(String(data: data, encoding: .utf8)!)
            completion(data, true)
        }.resume()
    }
    
    private func logRequest(_ url: URL, method: String, data: Data?, headers: [String : String]?) {
        var string = "curl --request \(method) \\"
        string += "\n--url \(url.absoluteString) \\"
        if let headers = headers {
            string += "\n--header '" + stringHeaders(headers) + "'\\"
        }
        if let data = data {
            string += "\n--data '" + String(data: data, encoding: .utf8)! + "'\\"
        }
        string.removeLast()
        string.removeLast()
        
        print(string)
    }

    private func stringHeaders(_ headers: [String : String]) -> String {
        var result = ""
        for (key, value) in headers {
            result += "\(key): \(value)"
        }
        return result
    }
    
}
