import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  GMSServices.provideAPIKey("AIzaSyCeK28-JRvQLZZ8NUg9C7xEEztxVu5djhQ")
    GeneratedPluginRegistrant.register(with: self)
    FirebaseApp.configure()
    return true || super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
