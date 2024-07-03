//
//  URLHandler.swift
//  react-native-google-auth
//
//  Created by Gradyn Wursten on 7/1/24.
//

import Foundation
import React
import GoogleSignIn

@objc(UrlHandler)
class UrlHandler: NSObject, RCTBridgeModule {
  
  static func moduleName() -> String! {
    return "UrlHandler"
  }

  @objc(handleOpenUrl:withResolver:withRejecter:)
  func handleOpenUrl(url: URL, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    let handled = GIDSignIn.sharedInstance.handle(url) { user, error in
      if let error = error {
        reject("URL_ERROR", "Failed to handle URL: \(error.localizedDescription)", error)
        return
      }

      guard let user = user else {
        reject("URL_ERROR", "Failed to handle URL: user is nil", nil)
        return
      }

      let userInfo: [String: Any] = [
        "givenName": user.profile?.givenName ?? "",
        "familyName": user.profile?.familyName ?? "",
        "id": user.userID ?? "",
        "idToken": user.authentication.idToken ?? ""
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
    
    if !handled {
      reject("URL_ERROR", "URL not handled by Google Sign-In", nil)
    }
  }
}
