import UIKit
import Flutter
import FirebaseCore
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()

        // Request notification permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permissions granted.")
            } else {
                print("Notification permissions denied.")
            }
        }
        // Set UNUserNotificationCenterDelegate
        UNUserNotificationCenter.current().delegate = self

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Handle notification when the app is in the foreground
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Customize how the notification is presented while the app is in the foreground
        completionHandler([.alert, .badge, .sound])
    }

    // Handle notification when the app is in the background or terminated
    override func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        print("Received remote notification while in background or terminated.")

        // Handle the received notification data as needed

        completionHandler(.newData)
    }
}
