import * as React from 'react';
import { useState } from 'react';
import { Button, SafeAreaView, StyleSheet, Text, TextInput } from 'react-native';
import { SignInWithGoogle } from 'react-native-google-auth';
import type { UserInfo } from '../../src/UserInfo';


export default function App() {
  const [clientId, setClientId] = useState<string>("");
  const [userInfo, setUserInfo] = useState<UserInfo>({familyName: "", givenName: "", id: "", idToken: ""})

  return (
    <SafeAreaView>
      <Text>SignInWithGoogle</Text>
      <TextInput placeholder='clientId' value={clientId} onChangeText={setClientId}/>
      <Button title="GO" onPress={async ()=>{
        setUserInfo(await SignInWithGoogle(clientId, "", ""));
      }}/>
      <Text>Family Name: {userInfo.familyName}</Text>
      <Text>Given Name: {userInfo.givenName}</Text>
      <Text>id: {userInfo.id}</Text>
      <Text>id token: {userInfo.idToken}</Text>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({

});
