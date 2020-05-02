import Flutter
import MSAL;
import UIKit

public class SwiftOnedrivepluginPlugin: NSObject, FlutterPlugin {

    let kClientID = "00bdbcc6-f08f-47c1-bdba-acc9381c362c"
    let kGraphEndpoint = "https://graph.microsoft.com/"
    let kAuthority = "https://login.microsoftonline.com/common"


    let kScopes: [String] = ["user.read"]

    var accessToken = String()
    var applicationContext: MSALPublicClientApplication?


    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "onedriveplugin", binaryMessenger: registrar.messenger())
        let instance = SwiftOnedrivepluginPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)

    }

    
    public func signIn(){
        let signInController =  ViewController.init();
        let rootViewController:UIViewController! = UIApplication.shared.keyWindow?.rootViewController
        if (rootViewController is UINavigationController) {
            print("1111")
            (rootViewController as! UINavigationController).pushViewController(signInController,animated:true)
        } else {
             print("2222")
            let navigationController:UINavigationController! = UINavigationController(rootViewController:signInController)
            rootViewController.present(navigationController, animated:true, completion:nil)
        }
        
        
//        let  controller = UIApplication.shared.window.rootViewController;
//        let signInController =  SignInOneDriverController.init();
//        controller.present(signInController, animated: false, completion: nil)
    }

   

    public func initMSAL() throws {
        // The MSAL Logger should be set as early as possible in the app launch sequence, before any MSAL
        // requests are made.
        print("initMSAL");
        let authority = try MSALAADAuthority(url: URL(string: kAuthority)!)
        let msalConfiguration = MSALPublicClientApplicationConfig(clientId: kClientID, redirectUri: nil, authority: authority)
        self.applicationContext = try MSALPublicClientApplication(configuration: msalConfiguration)
        MSALGlobalConfig.loggerConfig.setLogCallback { (logLevel, message, containsPII) in

            // If PiiLoggingEnabled is set YES, this block will potentially contain sensitive information (Personally Identifiable Information), but not all messages will contain it.
            // containsPII == YES indicates if a particular message contains PII.
            // You might want to capture PII only in debug builds, or only if you take necessary actions to handle PII properly according to legal requirements of the region
            if let displayableMessage = message {
                if (!containsPII) {
                    #if DEBUG
                    // NB! This sample uses print just for testing purposes
                    // You should only ever log to NSLog in debug mode to prevent leaking potentially sensitive information
                    print(displayableMessage)
                    #endif
                }
            }
        }
    }




    public func upload(localPath: String, cloudPath: String) {
        print("upload localPath  \(localPath)  cloudPath \(cloudPath)");
    }


    public func download(localPath: String, cloudPath: String) {
        print("download localPath  \(localPath)  cloudPath \(cloudPath)");
    }


    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        var methodName = call.method;
        switch methodName {
        case "initMSAL":
            do {
                try initMSAL()
            } catch {
                print(error)
            }
            break
        case "upload":
            if let args = call.arguments as? Dictionary<String, Any>, let cloudPath: String = args["cloudPath"] as? String, let localPath: String = args["localPath"] as? String {
                upload(localPath: localPath, cloudPath: cloudPath);
            }
//            var cloudPath: String? = call.arguments["cloudPath"] as String;
//            upload(localPath: localPath, cloudPath: cloudPath)
            break
        case "download":
            if let args = call.arguments as? Dictionary<String, Any>, let cloudPath: String = args["cloudPath"] as? String, let localPath: String = args["localPath"] as? String {
                download(localPath: localPath, cloudPath: cloudPath);
            }
//            if let args = call.arguments as? Dictionary<String, Any> {
//                var cloudPath: String? = args["cloudPath"] as? String;
//                var localPath: String? = args["localPath"] as String;
//                download(localPath: localPath, cloudPath: cloudPath)
//            }
            break
        case "signIn":
            signIn();
            
//            SignInOneDriverController *testController = [[TestViewController alloc]initWithNibName:@"TestViewController" bundle:nil];
//                        [controller presentViewController:testController animated:YES completion:nil];
         
            break
        case "signOut":

            break
        default:

            break
        }
        result("iOS " + UIDevice.current.systemVersion)
    }
}
