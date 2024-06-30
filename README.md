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


Next, select the "Credentials" menu from the slidebar


![Step 4](https://github.com/GNUGradyn/react-native-google-auth/blob/main/img/4.png?raw=true)
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

