//
//  AppDelegate.swift
//  RealtyPushNotification
//
//  Created by Shveta Puri on 11/12/20.
//

import UIKit
import CoreData
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //var url_delegate: updateUrl?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        
        registerForPushNotifications()
        // Check if launched from notification
        let notificationOption = launchOptions?[.remoteNotification]
        
        
    
//        if
//          let notification = notificationOption as? [String: AnyObject],
//            let aps = notification["aps"] as? [String: AnyObject] {
//            let link_url = notification["link_url"] as? String ?? ""
//            NewsItem.makeNewsItem(aps)
//
//            self.url_delegate?.newUrlAvailable(url: link_url )
//            NotificationCenter.default.post(name: Notification.Name("url"), object: link_url)
//
//            if let url = notification["link_url"] as? String{
//               UserDefaults.standard.set(url, forKey: "url")
//
//                }
//            print("in app delgate hi")
//            print(link_url)
          //(window?.rootViewController as? UITabBarController)?.selectedIndex = 1
        //}

        return true
    }
    //MARK: Push Notifcations

    
    func registerForPushNotifications() {
      
        UNUserNotificationCenter.current()
          .requestAuthorization(
            options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            print("Permission granted: \(granted)")
            guard granted else { return }
            
            
            
            self?.getNotificationSettings()
          }
    }
    
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        print("Notification settings: \(settings)")
        guard settings.authorizationStatus == .authorized else { return }
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
    
    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
      let token = tokenParts.joined()
      print("Device Token: \(token)")
    }
    
    func application(
      _ application: UIApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
      print("Failed to register: \(error)")
    }
    
    func application(
      _ application: UIApplication,
      didReceiveRemoteNotification userInfo: [AnyHashable: Any],
      fetchCompletionHandler completionHandler:
      @escaping (UIBackgroundFetchResult) -> Void
    ) {
//      guard let url = userInfo["link_url"] as? String else {
//        completionHandler(.failed)
//        return
//      }
//        self.url_delegate?.newUrlAvailable(url: url)
//
//        if let url = userInfo["link_url"] as? String{
//           UserDefaults.standard.set(url, forKey: "url")
//
//            }
//        NotificationCenter.default.post(name: Notification.Name("url"), object: url)

     // NewsItem.makeNewsItem(aps)
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

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "RealtyPushNotification")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


// Conform to UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                        willPresent notification: UNNotification,
                                        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
            {
                // Change this to your preferred presentation option
                completionHandler([.alert, .sound])
            }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        print("original body was : \(response.notification.request.content.userInfo["link_url"] as! String)")
        
        let url = response.notification.request.content.userInfo["link_url"] as! String
        //url_delegate?.newUrlAvailable(url: response.notification.request.content.userInfo["link_url"] as! String)

        NotificationCenter.default.post(name: Notification.Name("url"), object: url)

        
        print("Tapped in notification")

        }
    
}
//
//protocol updateUrl {
//    func newUrlAvailable(url: String)
//}


