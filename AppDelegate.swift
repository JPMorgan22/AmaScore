//
//  AppDelegate.swift
//  Score and Scout
//
//  Created by Sarah Morgan on 7/16/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        if Auth.auth().currentUser != nil {
            let layout = UICollectionViewFlowLayout()
            let mainFeedController = MainFeedViewController(collectionViewLayout: layout)
            let subscribeController = SubscribeTableViewController()
            let addPlayerController = AddPlayersController()
            let depthChartController = DepthChartController()
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
            let controllers = [mainFeedController, subscribeController, addPlayerController, depthChartController]
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
            window?.rootViewController = tabBarController
            
            mainFeedController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
            subscribeController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
            addPlayerController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
            depthChartController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 3)

        }
        else {
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
            let controller = LoginViewController()
            let navigationController = UINavigationController(rootViewController: controller)
            window?.rootViewController = navigationController //change controller to navigationcontroller
            
        }
        
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options [UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    
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


}

