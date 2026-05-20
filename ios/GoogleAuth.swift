import Foundation
import React
import UIKit

@objc(GoogleAuth)
class GoogleAuth: NSObject {

    @objc(signInWithGoogle:hostedDomainFilter:nonce:withResolver:withRejecter:)
    func signInWithGoogle(clientID: String, hostedDomainFilter: String?, nonce: String?, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        guard let presentingVC = getCurrentViewController() else {
          reject("PRESENTING_ERROR", "Unable to find a presenting view controller", nil)
          return
        }
        
        let signInConfig = GIDConfiguration(clientID: clientID, serverClientID: nil, hostedDomain: hostedDomainFilter, openIDRealm: nil)
        GIDSignIn.sharedInstance.configuration = signInConfig
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC, hint: nil, additionalScopes: nil, nonce: nonce) { result, error in
            if let error = error {
                reject("SIGN_IN_ERROR", error.localizedDescription, error)
                return
            }

            guard let user = result?.user else {
                reject("SIGN_IN_ERROR", "Google sign-in completed without a user", nil)
                return
            }

            let userInfo: [String: Any] = [
                "givenName": user.profile?.givenName ?? "",
                "familyName": user.profile?.familyName ?? "",
                "id": user.userID ?? "",
                "idToken": user.idToken?.tokenString ?? ""
            ]

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: userInfo, options: [])
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    resolve(jsonString)
                } else {
                    reject("JSON_ERROR", "Failed to encode JSON", nil)
                }
            } catch {
                reject("JSON_ERROR", "Failed to serialize user info: \(error.localizedDescription)", error)
            }
        }
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
