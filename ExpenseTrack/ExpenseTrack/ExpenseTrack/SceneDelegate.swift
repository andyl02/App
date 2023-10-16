import UIKit
import SwiftUI
import UserNotifications

/// A class that manages the application's scenes.
///
/// `SceneDelegate` is responsible for creating the application's main window and setting up the root view controller. It also requests notification authorization when a new scene session is being created.
///
/// - Tag: SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    /// The main window of the application.
    ///
    /// This window hosts the application's content. It is created when a new scene session is being created.
    var window: UIWindow?

    /// Called when a new scene session is being created.
    ///
    /// This method requests notification authorization and sets up the application's main window and root view controller.
    ///
    /// - Parameters:
    ///   - scene: The scene being created.
    ///   - session: The new scene session.
    ///   - connectionOptions: Options for connecting the scene.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Request notification authorization
        requestNotificationAuthorization()
        
        // Ensure the scene is of type UIWindowScene, else return
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create a new UIWindow using the windowScene
        let window = UIWindow(windowScene: windowScene)
        
        // Set the root view controller of the window
        window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(ExpenseManager()))
        
        // Assign the window to the window property
        self.window = window
        
        // Make the window key and visible
        window.makeKeyAndVisible()
    }
    
    /// Requests notification authorization from the user.
    ///
    /// This method requests the user's permission to send notifications. It is called when a new scene session is being created.
    private func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification Permission granted!")
            } else {
                print("Notification Permission denied.")
            }
        }
    }
}
