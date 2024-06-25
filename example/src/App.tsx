import * as React from 'react';
import { useState } from 'react';
import { Button, SafeAreaView, StyleSheet, Text, TextInput } from 'react-native';
import { SignInWithGoogle } from 'react-native-google-auth';


export default function App() {
  const [clientId, setClientId] = useState<string>("");

  return (
    <SafeAreaView>
      <Text>SignInWithGoogle</Text>
      <TextInput placeholder='clientId' value={clientId} onChangeText={setClientId}/>
      <Button title="GO" onPress={()=>{
        SignInWithGoogle(clientId, null, true, false, false);
      }}/>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({

});
