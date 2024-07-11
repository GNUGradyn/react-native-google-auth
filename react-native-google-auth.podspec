require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

Pod::Spec.new do |s|
  s.name         = "react-native-google-auth"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/GNUGradyn/react-native-google-auth.git" }

  s.source_files = "ios/**/*.{h,m,mm,swift}", "GoogleSignIn-iOS/GoogleSignIn/Sources/**/*.{h,m,mm,swift}"
  s.public_header_files = "GoogleSignIn-iOS/GoogleSignIn/Sources/Public/GoogleSignIn/*.h"
  s.private_header_files = "GoogleSignIn-iOS/GoogleSignIn/Sources/**/*.h"
  
  s.resource_bundle = {
    'GoogleSignIn' => ['GoogleSignIn-iOS/GoogleSignIn/Sources/{Resources,Strings}/*']
  }

  # We can remove this when the actual pod is merged. the first 2 are for the finished pod, the second two are for the example app which is relative to the repo source
  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '"$(inherited)" "$(PODS_ROOT)/GoogleSignIn-iOS/GoogleSignIn/Sources/Public/GoogleSignIn" "$(PODS_ROOT)/GoogleSignIn-iOS/GoogleSignIn/Sources"'
  }

  s.user_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '"$(inherited)" "$(PODS_ROOT)/GoogleSignIn-iOS/GoogleSignIn/Sources/Public/GoogleSignIn" "$(PODS_ROOT)/GoogleSignIn-iOS/GoogleSignIn/Sources"'
  }
  
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
        "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\"",
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
