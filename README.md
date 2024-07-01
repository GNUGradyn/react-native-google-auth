# react-native-google-auth

Google sign-in for react native

## Installation

```sh
npm install react-native-google-auth
```
or
```sh
yarn add react-native-google-auth
```

### Android linking
No additional steps are required to link the libraries on android
### iOS Linking
Run `pod install` in the iOS directory of your app to link the libraries
## Setup
To get started, we need to create a project in the [Google Cloud Console](https://console.cloud.google.com/). Begin by creating a new project for your app if you have not done so already


![Step 1](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/1.png?raw=true)
![Step 2](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/2.png?raw=true)


Next up, navigate to the "APIs & Services" Menu using either the search bar or the quick access menu


![Step 3](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/3.png?raw=true)


Next, select the "Oauth consent screen" menu from the slidebar

![Step 4](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/6.png?raw=true)


Select "External" as the user type and click Create

![Step 5](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/7.png?raw=true)

Enter the name of your app for the app name. Select an email where users can contact you in the "User support email" dropdown. You can optionally upload an app logo for the consent screen, but this will require you to keep your app in internal mode until it is approved by google. If your application has a home page, privacy policy, or TOS, you can enter those here for them to be shown on the consent screen. Add a developer contact email address and press "Save and continue"

![Step 6](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/8.png?raw=true)

Next up, we must create a client ID. Click credentials in the menu on the left

![Step 7](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/4.png?raw=true)


Click "Create Credentials" in the top menu and select "OAuth client ID"

![Step 8](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/5.png?raw=true)

Set the application type to "Web Application". **YOU MUST CHOOSE WEB APPLICATION EVEN IF YOU ARE MAKING AN ANDROID AND/OR IOS APP.** The Android/iOS clients will come later. You can change the name if you wish. Click Create. If you get a pop-up after the following screen with credentials, just click Ok.

![Step 9](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/9.png?raw=true)

### Android configuration
Skip this section if you do not intend to support Android.

Click "Create Credentials" in the top menu and select "OAuth client ID"

![Step 10](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/5.png?raw=true)

This time, Select "Android" as the Application Type. Set the Package Name field to the package name for your app. If you're unsure what this is, navigate to android/app/src/main/java/(follow the directory tree up until you see files)/MainActivity.(kt/java). The package name will be at the top after the word "package".

Next, run the following command from the root of the React Native project to get the SHA1 certificate fingerprint. `keytool -keystore android/app/debug.keystore -list -alias androiddebugkey -storepass android -keypass android -v` It will be after the word `SHA-1`. Finally, click create. Repeat this process with any additional keystores such as your production keystore.

![Step 11](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/10.png?raw=true)
### iOS configuration
Skip this section if you do not intend to support iOS

Click "Create Credentials" in the top menu and select "OAuth client ID"

![Step 12](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/5.png?raw=true)

This time, Select "iOS" as the Application Type. Change the Name if you like. Set the Bundle ID to your apps bundle ID. You can find this by opening the ios/(app name).xcodeproj file in xcode and double clicking the name of your project in the file browser on the left, choosing the first target, going to the general tab, and checking under "Identity". Fill out the App store ID if you have one and optionally fill out the Team ID. Click Create.

![Step 13](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/11.png?raw=true)


![Step 14](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/12.png?raw=true)

If you get a pop-up labeled "OAuth client created", dismiss it with the ok button.

Back in xCode, open the "Info" file from the file explorer on the left. Hover over the right side of the name of the bottom key and click the plus button. Enter GIDClientID as the key. Set the type to String. Enter the iOS client ID from the google cloud console as the value.

![Step 14](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/13.png?raw=true)

Back in the Google Cloud Console, click your iOS client ID and copy the "iOS URL scheme" under Additional information

![Step 15](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/14.png?raw=true)

Back in xCode in the Info file again, click the + next to GIDClientID. Choose URL Types from the dropdown. Expand this item, expand item 0, and change the URL identifier to the value you copied earlier. Check for trailing whitespace around this value and remove it.

![Step 16](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/15.png?raw=true)

## Usage

To sign in with google and receive a [UserInfo](https://github.com/GNUGradyn/react-native-google-auth/blob/main/src/UserInfo.ts) object, simply
```js
import { SignInWithGoogle } from 'react-native-google-auth';

const result = await SignInWithGoogle(clientId, "", ""); // MAKE SURE THE CLIENT ID IS THE WEB CLIENT ID, EVEN IF YOU ARE ON ANDROID OR IOS
```

Once you are signed in, you can now request additional scopes and receive an [AuthorizationResult](https://github.com/GNUGradyn/react-native-google-auth/blob/main/src/AuthorizationResult.ts)
```js
import { AuthorizeWithGoogle } from 'react-native-google-auth';

const result = await AuthorizeWithGoogle(["https://www.googleapis.com/auth/drive.appdata"]); 
```
## Contributing
See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.
## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)

