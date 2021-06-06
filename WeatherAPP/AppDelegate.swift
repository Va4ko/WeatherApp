//
//  AppDelegate.swift
//  WeatherAPP
//
//  Created by Vachko on 3.06.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


//    func popAlert(_ message: String, action Action: UIAlertAction ) {
//        DispatchQueue.main.async {
//            let viewController = self.currentVC()
//            let alert = UIAlertController(title: "Attention!", message: message, preferredStyle: .alert)
//            let action = UIAlertAction(title: "Try again!", style: .default){ _ in
//                getDataFromServer(completion: {
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
//                    alert.dismiss(animated: true, completion: nil)
//                })
//            }
//
//            alert.addAction(action)
//            viewController.present(alert, animated: true)
//        }
//    }
    
}

extension AppDelegate {
    func currentVC() -> UIViewController {
        
        let keyWindow = UIWindow.key
        var currentViewCtrl: UIViewController = keyWindow!.rootViewController!
        while (currentViewCtrl.presentedViewController != nil) {
            currentViewCtrl = currentViewCtrl.presentedViewController!
        }
        return currentViewCtrl
    }
}

