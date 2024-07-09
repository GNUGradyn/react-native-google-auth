import Foundation
import GoogleSignIn
import React

@objc(GoogleAuth)
class GoogleAuth: NSObject {

    @objc(signInWithGoogle:hostedDomainFilter:nonce:withResolver:withRejecter:)
    func signInWithGoogle(clientID: String, hostedDomainFilter: String?, nonce: String?, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        let gidConfig = GIDConfiguration(clientID: clientID)
        
        guard let presentingVC = getCurrentViewController() else {
          reject("PRESENTING_ERROR", "Unable to find a presenting view controller", nil)
          return
        }
        
        let signInConfig = GIDConfiguration(clientID: clientID, serverClientID: nil, hostedDomain: hostedDomainFilter, openIDRealm: nil)
        GIDSignIn.sharedInstance.configuration = signInConfig
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC, hint: nil, additionalScopes: nil, nonce: <#T##String?#>)
    }
    
    private func getCurrentViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let rootViewController = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
          return nil
        }

        var currentViewController = rootViewController
        while let presentedViewController = currentViewController.presentedViewController {
          currentViewController = presentedViewController
        }

        return currentViewController
      }
    
    
}
