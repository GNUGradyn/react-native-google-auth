      //
//  GoogleSignInInitializer.swift
//  react-native-google-auth
//
//  Created by Gradyn Wursten on 7/8/24.
//

import Foundation
import UIKit

@objc(GoogleSignInInitializer)
class GoogleSignInInitializer: NSObject {
  override init() {
    super.init()
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(didFinishLaunching(notification:)),
      name: UIApplication.didFinishLaunchingNotification,
      object: nil
    )
  }

  @objc
  func didFinishLaunching(notification: Notification) {
    guard let application = notification.object as? UIApplication else {
      return
    }

    let appDelegate = GoogleSignInAppDelegate()
    let originalDelegate = application.delegate

    // Swizzle methods to inject our delegate
    let originalSelector = #selector(UIApplicationDelegate.application(_:open:options:))
    let swizzledSelector = #selector(GoogleSignInAppDelegate.application(_:open:options:))

    let originalMethod = class_getInstanceMethod(type(of: originalDelegate!), originalSelector)
    let swizzledMethod = class_getInstanceMethod(GoogleSignInAppDelegate.self, swizzledSelector)

    if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
      method_exchangeImplementations(originalMethod, swizzledMethod)
    }
  }
}
