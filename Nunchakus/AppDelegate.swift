//
//  AppDelegate.swift
//  Nunchakus
//
//  Created by sungrow on 2017/3/21.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit
import Toaster
import ReachabilitySwift

enum NetStatus {
    case notNet         // 网络不可用
    case wifiNet        // WiFi无线网络
    case cellularNet    // 蜂窝数据
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var netStatus: NetStatus = .notNet
    fileprivate let reachability = Reachability()!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITabBar.appearance().tintColor = UIColor.globalColor()
        UINavigationBar.appearance().tintColor = UIColor.globalColor()
        ToastView.appearance().backgroundColor = UIColor.globalColor()
        ToastView.appearance().textInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        ToastView.appearance().font = UIFont.systemFont(ofSize: 17)
        ToastView.appearance().textColor = UIColor.black
        ToastView.appearance().bottomOffsetPortrait = 65
        ToastView.appearance().bottomOffsetLandscape = 65
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.rootViewController = MainTabBarController()
        UIApplication.shared.statusBarStyle = .lightContent
        
        reachabilityAction()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    deinit {
        reachability.stopNotifier()
    }

}

extension AppDelegate {
    fileprivate func reachabilityAction() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        reachability.whenReachable = {[weak self] reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
//            DispatchQueue.main.async {
//            }
            if reachability.isReachableViaWiFi {
                // wifi
                self?.netStatus = .wifiNet
            } else {
                // 蜂窝移动数据
                self?.netStatus = .cellularNet
            }
        }
        reachability.whenUnreachable = {[weak self] reachability in
            self?.netStatus = .notNet
//            DispatchQueue.main.async {
//            }
        }
    }
}

