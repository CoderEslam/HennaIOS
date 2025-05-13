import SwiftUI
import FirebaseMessaging
import FirebaseCore
import ComposeApp

@main
struct iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegateCompose.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegateCompose: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure() //important
        
        //By default showPushNotification value is true.
        //When set showPushNotification to false foreground push  notification will not be shown.
        //You can still get notification content using #onPushNotification listener method.
        NotifierManager.shared.initialize(configuration: NotificationPlatformConfigurationIos(
            showPushNotification: true,
            askNotificationPermissionOnStart: true,
            notificationSoundName: nil)
        )
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        Messaging.messaging().apnsToken = deviceToken
        print("ESLAMTOKEN => 1 \(tokenString)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        NotifierManager.shared.onApplicationDidReceiveRemoteNotification(userInfo: userInfo)
        return UIBackgroundFetchResult.newData
    }
    
   
    
}


class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID AZ: \(messageID)")
        }
        
        print(userInfo)
        
        let content = UNMutableNotificationContent()
        content.title = "New Message"
        content.body = "You have a new message!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "messageNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
    -> UIBackgroundFetchResult {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID GH: \(messageID)")
        }
        
        print(userInfo)
        
        
        let content = UNMutableNotificationContent()
        content.title = "New Message"
        content.body = "You have a new message!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "messageNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        return UIBackgroundFetchResult.newData
        
    }
    
    
    
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID ESLAM: \(messageID)")
        }
        
        print(userInfo)
        
        
        let alert = UIAlertController(title: "Notification", message: notification.request.content.body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        
        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true, completion: nil)
        }
        
        
        completionHandler([.alert, .sound])
        
    }
    
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID GHAZY: \(messageID)")
        }
        print(userInfo)
    }
    
    func showNotificationBanner(message: String) {
        guard let window = UIApplication.shared.windows.first else { return }
        
        let bannerHeight: CGFloat = 80
        let bannerView = NotificationBannerView(frame: CGRect(x: 0, y: -bannerHeight, width: window.frame.width, height: bannerHeight))
        bannerView.showMessage(message)
        
        window.addSubview(bannerView)
        
        UIView.animate(withDuration: 0.5, animations: {
            bannerView.frame.origin.y = 0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 2.0, options: [], animations: {
                bannerView.frame.origin.y = -bannerHeight
            }) { _ in
                bannerView.removeFromSuperview()
            }
        }
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        guard let fcmToken = fcmToken else {
            print("Failed to retrieve FCM Token")
            return
        }
        let defaults = UserDefaults.standard
        defaults.set("\(fcmToken)", forKey: "userToken")
        
        if let deviceID = UIDevice.current.identifierForVendor?.uuidString {
            print("Device ID: \(deviceID)")

            // Create an instance of AuthService and call the auth method
            //let authService = AuthService(deviceId: deviceID, fcmToken: fcmToken)

        } else {
            print("Failed to retrieve Device ID")
        }
        
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ]
        print("FCM TOKEN => \(dataDict)")
        if let deviceID = UIDevice.current.identifierForVendor?.uuidString {
            print("Device ID: \(deviceID)")
        } else {
            print("Failed to retrieve Device ID")
        }
        
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
    
    class NotificationBannerView: UIView {
        private let messageLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = UIColor.black.withAlphaComponent(0.8)
            messageLabel.textColor = .white
            messageLabel.font = UIFont.boldSystemFont(ofSize: 16)
            messageLabel.numberOfLines = 0
            
            addSubview(messageLabel)
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
            
            layer.cornerRadius = 10
            layer.masksToBounds = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func showMessage(_ message: String) {
            messageLabel.text = message
        }
    }
}
