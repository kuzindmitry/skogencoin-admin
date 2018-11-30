//
//  UINavigationController.swift
//  SkogenCoinAdmin
//
//  Created by Dmitry Kuzin on 30/11/2018.
//  Copyright © 2018 SkogenCoin. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    var hide: Bool {
        get {
            return navigationBar.shadowImage == UIImage() && !navigationBar.isTranslucent
        }
        set {
            if newValue {
                navigationBar.shadowImage = UIImage()
                navigationBar.isTranslucent = true
            } else {
                navigationBar.shadowImage = nil
                navigationBar.isTranslucent = false
            }
        }
    }
    
    func setBarTintColor(_ color: UIColor) {
        navigationBar.barTintColor = color
    }
    
    func setTintColor(_ color: UIColor) {
        navigationBar.tintColor = color
    }
    
    func setTitleColor(_ color: UIColor) {
        navigationBar.titleTextAttributes = [.foregroundColor: color]
    }
    
}
