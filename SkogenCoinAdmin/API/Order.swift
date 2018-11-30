//
//  Order.swift
//  SkogenCoinAdmin
//
//  Created by Dmitry Kuzin on 30/11/2018.
//  Copyright © 2018 SkogenCoin. All rights reserved.
//

import Foundation

struct Order: Decodable {
    let status: String
    let _id: String
    let items: [OrderItem]
    let profile: String?
    let date: String
    let createTime: String
    
    var createdDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: createTime) ?? Date()
    }
}

struct OrderItem: Decodable {
    let _id: String
    let item: OrderItemValue
    let quantity: Int
}

struct OrderItemValue: Decodable {
    let _id: String
    let meal: Meal
    let price: Int
    let volume: String
    let type: String
}

struct Meal: Decodable {
    let _id: String
    let name: String
    let photo: String
    let description: String
    let createTime: String
}

struct PushSettings: Codable {
    let deviceId: String
    let platform: String
    
    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
