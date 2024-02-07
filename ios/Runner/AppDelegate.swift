import UIKit
import google_mobile_ads
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self
      }
    GeneratedPluginRegistrant.register(with: self)
          FLTGoogleMobileAdsPlugin.registerNativeAdFactory(self, factoryId: "small.nativeAd", nativeAdFactory: GADNativeFactory())
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
