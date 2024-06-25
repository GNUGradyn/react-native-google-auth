import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-google-auth' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const GoogleAuth = NativeModules.GoogleAuth
  ? NativeModules.GoogleAuth
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function SignInWithGoogle(clientId: string, nonce: string | null, filterByAuthorizedAccounts: boolean, requestVerifiedPhoneNumber: boolean, autoSelectEnabled: boolean): Promise<any> {
  return GoogleAuth.SignInWithGoogle(clientId, nonce, filterByAuthorizedAccounts, requestVerifiedPhoneNumber, autoSelectEnabled);
}
