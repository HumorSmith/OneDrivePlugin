//
// Created by 静宸 on 2020/5/1.
//

import Foundation
import UIKit
import MSAL;

public class SignInOneDriverController: UIViewController, URLSessionDelegate {
    let kClientID = "00bdbcc6-f08f-47c1-bdba-acc9381c362c"
    let kGraphEndpoint = "https://graph.microsoft.com/"
    let kAuthority = "https://login.microsoftonline.com/common"


    let kScopes: [String] = ["user.read"]
    var webViewParamaters: MSALWebviewParameters?
    var currentAccount: MSALAccount?
    var accessToken = String()
    var applicationContext: MSALPublicClientApplication?
    var isFirstFailed = false;
//
//    override public func appea() {
//        super.viewDidLoad()
//        initUI();
//        do {
//              try self.initMSAL()
//          } catch let error {
//              self.updateLogging(text: "Unable to create Application Context \(error)")
//          }
//        signIn();
//
//    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        initUI();
        do {
            try self.initMSAL()
            signIn();

        } catch let error {
            self.updateLogging(text: "Unable to create Application Context \(error)")
        }
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        signIn();
    }


    func initUI() {
        // Add call Graph button
        var callGraphButton = UIButton();
        callGraphButton.translatesAutoresizingMaskIntoConstraints = false;
        callGraphButton.setTitle("Call Microsoft Graph API", for: .normal);
        callGraphButton.setTitleColor(.blue, for: .normal);
        callGraphButton.addTarget(self, action: #selector(callGraphAPI(_:)), for: .touchUpInside);
        self.view.addSubview(callGraphButton);

    }


    @objc func callGraphAPI(_ sender: UIButton) {
        self.acquireTokenInteractively()
        self.loadCurrentAccount { (account) in

            guard let currentAccount = account else {

                // We check to see if we have a current logged in account.
                // If we don't, then we need to sign someone in.
                self.acquireTokenInteractively()
                return
            }

            self.acquireTokenSilently(currentAccount)
        }
    }


    func initWebViewParams() {
        self.webViewParamaters = MSALWebviewParameters(authPresentationViewController: self)
    }

    public func signIn() {
        print("signIn");
        self.loadCurrentAccount { (account) in

            guard let currentAccount = account else {

                // We check to see if we have a current logged in account.
                // If we don't, then we need to sign someone in.
                print("signIn acquireTokenInteractively");

                self.acquireTokenInteractively()
                return
            }
            print("signIn acquireTokenSilently");
            self.acquireTokenSilently(currentAccount)
        }
//        let parameters = MSALInteractiveokenParameters(scopes: kScopes, webviewParameters: self.webViewParamaters!)
//        self.applicationContext!.acquireToken(with: parameters) { (result, error) in
//            print(result)/* Add your handling logic */
//        }
    }


    func initMSAL() throws {

        guard let authorityURL = URL(string: kAuthority) else {
            self.updateLogging(text: "Unable to create authority URL")
            return
        }

        let authority = try MSALAADAuthority(url: authorityURL)

        let msalConfiguration = MSALPublicClientApplicationConfig(clientId: kClientID, redirectUri: nil, authority: authority)
        self.applicationContext = try MSALPublicClientApplication(configuration: msalConfiguration)
        self.initWebViewParams()
    }


    func acquireTokenInteractively() {

        guard let applicationContext = self.applicationContext else {
            return
        }
        guard let webViewParameters = self.webViewParamaters else {
            return
        }

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


            SwiftOnedrivepluginPlugin.accessToken = result.accessToken;

            self.updateLogging(text: "Access token is \(self.accessToken)")
            self.updateCurrentAccount(account: result.account)
            self.getContentWithToken()
        }
    }

    typealias AccountCompletion = (MSALAccount?) -> Void

    func loadCurrentAccount(completion: AccountCompletion? = nil) {

        guard let applicationContext = self.applicationContext else {
            return
        }

        let msalParameters = MSALParameters()
        msalParameters.completionBlockQueue = DispatchQueue.main

        // Note that this sample showcases an app that signs in a single account at a time
        // If you're building a more complex app that signs in multiple accounts at the same time, you'll need to use a different account retrieval API that specifies account identifier
        // For example, see "accountsFromDeviceForParameters:completionBlock:" - https://azuread.github.io/microsoft-authentication-library-for-objc/Classes/MSALPublicClientApplication.html#/c:objc(cs)MSALPublicClientApplication(im)accountsFromDeviceForParameters:completionBlock:
        applicationContext.getCurrentAccount(with: msalParameters, completionBlock: { (currentAccount, previousAccount, error) in

            if let error = error {
                self.updateLogging(text: "Couldn't query current account with error: \(error)")
                if self.isFirstFailed{
                    return
                }
                self.isFirstFailed = true;
            }
            if let currentAccount = currentAccount {

                self.updateLogging(text: "Found a signed in account \(String(describing: currentAccount.username)). Updating data for that account...")

                self.updateCurrentAccount(account: currentAccount)

                if let completion = completion {
                    completion(self.currentAccount)
                }

                return
            }

            self.updateLogging(text: "Account signed out. Updating UX")
            self.accessToken = ""
            self.updateCurrentAccount(account: nil)

            if let completion = completion {
                completion(nil)
            }
        })
    }

    func updateLogging(text: String) {
        print("updateLogging\(text)");
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

            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            SwiftOnedrivepluginPlugin.mail = jsonData?["userPrincipalName"] as? String ?? "";
            SwiftOnedrivepluginPlugin.userName = jsonData?["displayName"] as? String ?? "";
//            SwiftOnedrivepluginPlugin.userName = dict!["displayName"] as String;
            self.updateLogging(text: "Result from Graph: \(jsonData))");
            DispatchQueue.main.async {
                SwiftOnedrivepluginPlugin.returnLoginInfo();
                self.dismiss(animated: true, completion: nil)
            }

        }.resume()
    }


    func acquireTokenSilently(_ account: MSALAccount!) {

        guard let applicationContext = self.applicationContext else {
            print("acquireTokenSilently guard return")
            return
        }

        /**

         Acquire a token for an existing account silently

         - forScopes:           Permissions you want included in the access token received
         in the result in the completionBlock. Not all scopes are
         guaranteed to be included in the access token returned.
         - account:             An account object that we retrieved from the application object before that the
         authentication flow will be locked down to.
         - completionBlock:     The completion block that will be called when the authentication
         flow completes, or encounters an error.
         */

        let parameters = MSALSilentTokenParameters(scopes: kScopes, account: account)

        applicationContext.acquireTokenSilent(with: parameters) { (result, error) in

            if let error = error {
                print("acquireTokenSilent  error\(error)")
                let nsError = error as NSError

                // interactionRequired means we need to ask the user to sign-in. This usually happens
                // when the user's Refresh Token is expired or if the user has changed their password
                // among other possible reasons.

                if (nsError.domain == MSALErrorDomain) {

                    if (nsError.code == MSALError.interactionRequired.rawValue) {

                        DispatchQueue.main.async {
                            self.acquireTokenInteractively()
                        }
                        return
                    }
                }

                self.updateLogging(text: "Could not acquire token silently: \(error)")
                return
            }

            guard let result = result else {

                self.updateLogging(text: "Could not acquire token: No result returned")
                return
            }

            self.accessToken = result.accessToken
            SwiftOnedrivepluginPlugin.accessToken = result.accessToken;
            self.updateLogging(text: "Refreshed Access token is \(self.accessToken)")
            self.getContentWithToken()
        }
    }


    func getGraphEndpoint() -> String {
        return kGraphEndpoint.hasSuffix("/") ? (kGraphEndpoint + "v1.0/me/") : (kGraphEndpoint + "/v1.0/me/");
    }

    func stringValueDic(_ str: String) -> [String: Any]? {

        let data = str.data(using: String.Encoding.utf8)

        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {

            return dict

        }

        return nil

    }


}
