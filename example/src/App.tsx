import * as React from 'react';
import { useState } from 'react';
import { Button, SafeAreaView, ScrollView, StyleSheet, Text, TextInput } from 'react-native';
import { AuthorizeWithGoogle, SignInWithGoogle } from 'react-native-google-auth';
import type { UserInfo } from '../../src/UserInfo';


export default function App() {
  const [clientId, setClientId] = useState<string>("");
  const [userInfo, setUserInfo] = useState<UserInfo>({familyName: "", givenName: "", id: "", idToken: ""})
  const [scopes, setScopes] = useState<string>("");
  const [authorizationResult, setAuthorizationResult] = useState();

  return (
    <SafeAreaView>
      <ScrollView>
        <Text style={{fontSize: 20}}>SignInWithGoogle</Text>
        <TextInput placeholder='clientId' value={clientId} onChangeText={setClientId}/>
        <Button title="GO" onPress={async ()=>{
          setUserInfo(await SignInWithGoogle(clientId, "", ""));
        }}/>
        <Text>Family Name: {userInfo.familyName}</Text>
        <Text>Given Name: {userInfo.givenName}</Text>
        <Text>id: {userInfo.id}</Text>
        <Text>id token: {userInfo.idToken}</Text>
        <Text style={{fontSize: 20}}>AuthorizeWithGoogle</Text>
        <TextInput placeholder='Scopes (comma delimited)' value={scopes} onChangeText={setScopes}/>
        <Button title='GO' onPress={async () => {
          setAuthorizationResult(await AuthorizeWithGoogle(scopes.split(",").map(x => x.trim())))
        }}/>
      </ScrollView>
    </SafeAreaView>
  );
}