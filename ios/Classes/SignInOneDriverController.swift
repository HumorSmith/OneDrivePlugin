//
// Created by 静宸 on 2020/5/1.
//

import Foundation
import UIKit
import MSAL;

public class SignInOneDriverController:UIViewController,URLSessionDelegate{
    let kScopes: [String] = ["user.read"]
    var webViewParamaters: MSALWebviewParameters?
        let kGraphEndpoint = "https://graph.microsoft.com/"
     var currentAccount: MSALAccount?
       var accessToken = String()
       var applicationContext : MSALPublicClientApplication?


    override public func viewDidLoad() {
        super.viewDidLoad()
        initWebViewParams();
        signIn();

    }
    func initWebViewParams() {
        self.webViewParamaters = MSALWebviewParameters(authPresentationViewController: self)
    }

    public func signIn() {
        acquireTokenInteractively();
//        let parameters = MSALInteractiveokenParameters(scopes: kScopes, webviewParameters: self.webViewParamaters!)
//        self.applicationContext!.acquireToken(with: parameters) { (result, error) in
//            print(result)/* Add your handling logic */
//        }
    }

    
    
    func acquireTokenInteractively() {
           
           guard let applicationContext = self.applicationContext else { return }
           guard let webViewParameters = self.webViewParamaters else { return }

           let parameters = MSALInteractiveTokenParameters(scopes: kScopes, webviewParameters: webViewParameters)
           parameters.promptType = .selectAccount
           
           applicationContext.acquireToken(with: parameters) { (result, error) in
               
               if let error = error {
                   
                   self.updateLogging(text: "Could not acquire token: \(error)")
                   return
               }
               
               guard let result = result else {
                   
                   self.updateLogging(text: "Could not acquire token: No result returned")
                   return
               }
               
               self.accessToken = result.accessToken
               self.updateLogging(text: "Access token is \(self.accessToken)")
               self.updateCurrentAccount(account: result.account)
               self.getContentWithToken()
           }
       }

    
    func updateLogging(text : String) {
           
        print(text);
       }
    
    
    func updateCurrentAccount(account: MSALAccount?) {
        self.currentAccount = account
     
    }
    
    
    
       func getContentWithToken() {
           
           // Specify the Graph API endpoint
           let graphURI = getGraphEndpoint()
           let url = URL(string: graphURI)
           var request = URLRequest(url: url!)
           
           // Set the Authorization header for the request. We use Bearer tokens, so we specify Bearer + the token we got from the result
           request.setValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               
               if let error = error {
                   self.updateLogging(text: "Couldn't get graph result: \(error)")
                   return
               }
               
               guard let result = try? JSONSerialization.jsonObject(with: data!, options: []) else {
                   
                   self.updateLogging(text: "Couldn't deserialize result JSON")
                   return
               }
               
               self.updateLogging(text: "Result from Graph: \(result))")
               
               }.resume()
       }

    
    func getGraphEndpoint() -> String {
        return kGraphEndpoint.hasSuffix("/") ? (kGraphEndpoint + "v1.0/me/") : (kGraphEndpoint + "/v1.0/me/");
    }
}
