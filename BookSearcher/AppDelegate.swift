//
//  AppDelegate.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let booksModule = BooksAssembly().makeModule()
        window?.rootViewController = UINavigationController(rootViewController: booksModule.viewController)
        window?.makeKeyAndVisible()
        
        return true
    }
}
