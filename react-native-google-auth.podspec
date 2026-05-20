require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'
google_sign_in_root = "GoogleSignIn-iOS"
google_sign_in_version = "7.2.0"
google_sign_in_header_search_paths = "\"$(inherited)\" \"$(PODS_TARGET_SRCROOT)\" \"$(PODS_TARGET_SRCROOT)/#{google_sign_in_root}\" \"$(PODS_TARGET_SRCROOT)/#{google_sign_in_root}/GoogleSignIn/Sources/Public\""

Pod::Spec.new do |s|
  s.name         = "react-native-google-auth"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "11.0" }
  s.source       = { :git => "https://github.com/GNUGradyn/react-native-google-auth.git" }
  s.swift_version = "5.0"
  s.source_files = [
    "ios/**/*.{h,m,mm,swift}",
    "#{google_sign_in_root}/GoogleSignIn/Sources/**/*.[mh]"
  ]
  s.public_header_files = "#{google_sign_in_root}/GoogleSignIn/Sources/Public/GoogleSignIn/*.h"
  s.private_header_files = "#{google_sign_in_root}/GoogleSignIn/Sources/**/*.h"
  s.frameworks = [
    "CoreGraphics",
    "CoreText",
    "Foundation",
    "LocalAuthentication",
    "Security",
    "UIKit"
  ]
  s.resource_bundle = {
    "GoogleSignIn" => ["#{google_sign_in_root}/GoogleSignIn/Sources/{Resources,Strings}/*"]
  }
  s.pod_target_xcconfig = {
    "GCC_PREPROCESSOR_DEFINITIONS" => "GID_SDK_VERSION=#{google_sign_in_version}",
    "HEADER_SEARCH_PATHS" => google_sign_in_header_search_paths,
    "SWIFT_OBJC_BRIDGING_HEADER" => "$(PODS_TARGET_SRCROOT)/ios/GoogleAuth-Bridging-Header.h",
    "DEFINES_MODULE" => "YES",
    "COMBINE_HIDPI_IMAGES" => "NO"
  }
  s.dependency "AppCheckCore", ">= 10.19.1", "< 11.0"
  s.dependency "AppAuth", ">= 1.7.3", "< 2.0"
  s.dependency "GTMAppAuth", ">= 4.1.1", "< 5.0"
  s.dependency "GTMSessionFetcher/Core", "~> 3.3"
  # Use install_modules_dependencies helper to install the dependencies if React Native version >=0.71.0.
  # See https://github.com/facebook/react-native/blob/febf6b7f33fdb4904669f99d795eba4c0f95d7bf/scripts/cocoapods/new_architecture.rb#L79.
  if respond_to?(:install_modules_dependencies, true)
    install_modules_dependencies(s)
  else
    s.dependency "React-Core"

    # Additional dependencies and configurations for the new architecture
    if ENV['RCT_NEW_ARCH_ENABLED'] == '1' then
      s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
      s.pod_target_xcconfig.merge!({
        "HEADER_SEARCH_PATHS" => "#{google_sign_in_header_search_paths} \"$(PODS_ROOT)/boost\"",
        "OTHER_CPLUSPLUSFLAGS" => "-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1",
        "CLANG_CXX_LANGUAGE_STANDARD" => "c++17"
      })
      s.dependency "React-Codegen"
      s.dependency "RCT-Folly"
      s.dependency "RCTRequired"
      s.dependency "RCTTypeSafety"
      s.dependency "ReactCommon/turbomodule/core"
    end
  end
end
