import { NativeModules, Platform } from 'react-native';
import type { UserInfo } from './UserInfo';
import type AuthorizationResult from './AuthorizationResult';

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

export const SignInWithGoogle = async (clientId: string, hostedDomainFilter: string, nonce: string): Promise<UserInfo> => {
  try {
    const userInfo: string = await GoogleAuth.SignInWithGoogle(clientId, hostedDomainFilter, nonce);
    return JSON.parse(userInfo);
  } catch (error: any) {
      throw new Error('Failed to get user info: ' + error.message);
  }
}

export const AuthorizeWithGoogle = async (scopes: string[]): Promise<AuthorizationResult> => {
  try {
    const authorizationResult: string = await GoogleAuth.AuthorizeWithGoogle(scopes);
    return JSON.parse(authorizationResult);
  } catch (error: any) {
    throw new Error("Failed to authorize with google: " + error.message)
  }
}
