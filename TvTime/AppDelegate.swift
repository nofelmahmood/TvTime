//
//  AppDelegate.swift
//  TvTime
//
//  Created by Nofel Mahmood on 08/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        let feedTabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed"), tag: 0)
        feedViewController.tabBarItem = feedTabBarItem
        
        let scheduleViewController = UINavigationController(rootViewController: ScheduleViewController())
        let scheduleTabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "schedule"), tag: 0)
        scheduleViewController.tabBarItem = scheduleTabBarItem
        
        let favoritesViewController = UINavigationController(rootViewController: FavoritesViewController())
        let favoritesTabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorites"), tag: 2)
        favoritesTabBarItem.selectedImage = UIImage(named: "favorites_selected")
        favoritesViewController.tabBarItem = favoritesTabBarItem
        
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let searchTabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)
        searchViewController.tabBarItem = searchTabBarItem
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([feedViewController, scheduleViewController, favoritesViewController, searchViewController], animated: true)
        tabBarController.selectedIndex = 0
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        let realm = RLMRealm.default()
        debugPrint("Path to realm file: " + realm.configuration.fileURL!.absoluteString)
        
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


}

