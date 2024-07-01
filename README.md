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

![Step 7](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/8.png?raw=true)

Click "Create Credentials" inm the top menu and select "OAuth client ID"

![Step 6](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/5.png?raw=true)
## Usage


You must 
```js
import { multiply } from 'react-native-google-auth';

// ...

const result = await multiply(3, 7);
```
## Contributing
See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.
## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)

