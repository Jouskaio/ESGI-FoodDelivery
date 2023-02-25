//
//  AppDelegate.swift
//  EFD-Boss
//
//  Created by Elsa on 10/02/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: DeliveryViewController())
        //HomeViewController()
        //DeliveryViewController()
        //DetailDeliveryViewController()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }


}
