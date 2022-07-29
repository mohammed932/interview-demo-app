import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {


    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {


        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController


        let WebViewChannel = FlutterMethodChannel(name: "com.najiz_flutter.main/downloadMicroApp",
            binaryMessenger: controller.binaryMessenger)
        
          let  configChannel = FlutterMethodChannel(name: "com.najiz_flutter.main/configurations",
            binaryMessenger: controller.binaryMessenger)


        // - Handling Opening web view from Main App
        WebViewChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject( forKey: "AppRoute")
            userDefaults.removeObject( forKey: "MicroAppName")
            guard let args = call.arguments as? [String: Any] else {
                result("You have to specify the directory path")
                return
            }

            switch call.method {
            case "openWebView":
                guard let path = args["path"] as? String else {
                    result("You have to specify the directory path")
                    return }
                

                if let token = args["token"] as? String {
                    userDefaults.set(token, forKey: "Token")
                } else {
                    userDefaults.removeObject(forKey: "Token")
                }
                
                if let route = args["route"] as? String {
                    userDefaults.set(route, forKey: "AppRoute")
                    userDefaults.set(route, forKey: "MicroAppName")
                }
                
                userDefaults.set(path, forKey: "assetsFolder")

                if let route = args["route"] as? String {
                    userDefaults.set(route, forKey: "AppRoute")
                    userDefaults.set(route, forKey: "MicroAppName")
                }
                userDefaults.synchronize()
                
                let ionicEngine = IonicEnginViewController()
                ionicEngine.loadView(assetsFolder: path)

                let storyBoard = UIStoryboard(name: "Main", bundle: nil)

                let viewController = storyBoard.instantiateViewController(withIdentifier: "IonicEnginViewController") as! IonicEnginViewController
                viewController.modalPresentationStyle = .fullScreen
                controller.present(viewController, animated: true)

                NotificationCenter.default.addObserver(self, selector: #selector(self.dismissMicroApp), name: Notification.Name("NotificationIdentifier"), object: nil)

                result("Open Web View on this Directory:\n\n \(path)")

            default:
                result(FlutterResult.self)
            }
        })

        // - Save App Configurations

        configChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

            guard let args = call.arguments as? [String: [String: String]] else {
                result("You have to specify configurations ")
                return
            }

            switch call.method {
            case "saveConfig":
                guard let config = args["config"] else {
                    result("You have to specify the configuration to be saved")
                    return }
                
                  self.saveConfigData(with: config)

                result("Save this configurations to native \n\n \(config)")

            default:
                result(FlutterResult.self)
            }
        })


        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    @objc func dismissMicroApp() {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

        controller.dismiss(animated: true, completion: nil)
    }

    func saveConfigData(with config: [String: String]) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(config["baseUrl"], forKey: "ServerURL");
        userDefaults.set(config["ApplicationInsightsKey"], forKey: "InstrumentationKey");
        userDefaults.set(config["SSOUrl"], forKey: "SSO_Url");
        userDefaults.set(config["ClientId"], forKey: "ClientId");
        userDefaults.set(config["Secret"], forKey: "ClientSecret");
        userDefaults.set(config["SiteKey"], forKey: "SiteKey");
        userDefaults.synchronize();
    }

}
