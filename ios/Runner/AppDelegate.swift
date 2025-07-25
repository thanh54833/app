import UIKit
import Flutter

import omicall_flutter_plugin
import OmiKit
import flutter_uploader


func registerPlugins(registry: FlutterPluginRegistry) {
    GeneratedPluginRegistrant.register(with: registry)
}

@main
@objc class AppDelegate: FlutterAppDelegate {

   var pushkitManager: PushKitManager?
    var provider: CallKitProviderDelegate?
    var voipRegistry: PKPushRegistry?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    guard let controller = window?.rootViewController as? FlutterViewController else {
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    let flavorChannel = FlutterMethodChannel(name: "demo", binaryMessenger: controller.binaryMessenger)
         // 2
    flavorChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
    switch call.method {
             // 3
        case "getPackage":
            result("YWlhLWNvbW1vbi1=")
        default:
            result(FlutterMethodNotImplemented)
        }
    })

          // omicall.
          // KEY_OMI_APP_ENVIROMENT_PRODUCTION
          // KEY_OMI_APP_ENVIROMENT_SANDBOX
          OmiClient.setEnviroment(KEY_OMI_APP_ENVIROMENT_PRODUCTION, userNameKey: "full_name",maxCall:1,callKitImage:"call_image",typePushVoip:"default")
          //OmiClient.setLogLevel(5)
          provider = CallKitProviderDelegate.init(callManager: OMISIPLib.sharedInstance().callManager)
          voipRegistry = PKPushRegistry.init(queue: .main)
          pushkitManager = PushKitManager.init(voipRegistry: voipRegistry)
          // omicall end.

  //       FlutterDownloaderPlugin.setPluginRegistrantCallback { registry in
  //                   if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
  //                       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
  //                   }
  //               }

        SwiftFlutterUploaderPlugin.registerPlugins = registerPlugins

//        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)//facebook

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    override
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        var value = SwiftOmikitPlugin.processUserActivity(userActivity: userActivity)
        return value
    }
}
