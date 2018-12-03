//
//  AppDelegate.swift
//  SkogenCoinAdmin
//
//  Created by Dmitry Kuzin on 29/11/2018.
//  Copyright © 2018 SkogenCoin. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        
        if ProfileDatabaseManager().getProfile()?.token == nil {
            let phoneViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhoneViewController") as! PhoneViewController
            let navigationController = UINavigationController(rootViewController: phoneViewController)
            navigationController.isNavigationBarHidden = true
            navigationController.interactivePopGestureRecognizer?.delegate = nil
            window?.rootViewController = navigationController
        }
    
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device token - ", token)
        let pushSettings = PushSettings(deviceId: token, platform: "ios")
        APIClient.shared.registerPush(pushSettings) {
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NotificationCenter.default.post(name: updateNotification, object: nil)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: updateNotification, object: nil)
        application.applicationIconBadgeNumber = -1
    }
    
}

