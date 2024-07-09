#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(GoogleAuth, NSObject)

RCT_EXTERN_METHOD(signInWithGoogle:(NSString *)clientID hostedDomainFilter:(NSString *)hostedDomain nonce:(NSString *)nonce withResolver:(RCTPromiseResolveBlock)resolve withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
