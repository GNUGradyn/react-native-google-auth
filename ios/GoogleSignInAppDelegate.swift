//
//  GoogleSignInAppDelegate.swift
//  react-native-google-auth
//
//  Created by Gradyn Wursten on 7/8/24.
//
import Foundation
import UIKit

@objc(GoogleSignInAppDelegate)
public class GoogleSignInAppDelegate: NSObject {
  
  @objc(application:openURL:options:)
  public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
}
