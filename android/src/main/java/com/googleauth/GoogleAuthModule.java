package com.googleauth;

import androidx.credentials.exceptions.GetCredentialException;
import android.os.CancellationSignal;

import androidx.credentials.CredentialManagerCallback;
import androidx.credentials.GetCredentialRequest;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.credentials.CredentialManager;
import androidx.credentials.GetCredentialResponse;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.google.android.libraries.identity.googleid.GetSignInWithGoogleOption;
import com.google.android.libraries.identity.googleid.GoogleIdTokenCredential;
import com.google.gson.Gson;

import java.util.concurrent.Executors;

@ReactModule(name = GoogleAuthModule.NAME)
public class GoogleAuthModule extends ReactContextBaseJavaModule {
  public static final String NAME = "GoogleAuth";

  CredentialManager credentialManager = null;

  public GoogleAuthModule(ReactApplicationContext reactContext) {

    super(reactContext);


  }

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }

  @ReactMethod
  public void SignInWithGoogle(String clientId, @Nullable String hostedDomainFilter, String nonce, Promise promise) {
    if (credentialManager == null) {
      credentialManager = CredentialManager.create(getCurrentActivity());
    }
    var googleIdOption = new GetSignInWithGoogleOption(clientId, hostedDomainFilter, nonce);

    GetCredentialRequest request = new GetCredentialRequest.Builder()
      .addCredentialOption(googleIdOption)
      .build();

    credentialManager.getCredentialAsync(
      getCurrentActivity().getApplicationContext(),
      request,
      new CancellationSignal(),
      Executors.newSingleThreadExecutor(),
      new CredentialManagerCallback<GetCredentialResponse, GetCredentialException>() {
        @Override
        public void onResult(@NonNull GetCredentialResponse result) {
          promise.resolve(new Gson().toJson(GoogleIdTokenCredential.createFrom(result.getCredential().getData())));
        }
        @Override
        public void onError(@NonNull GetCredentialException error) {
          promise.reject(error);
        }
      }
      );
  }
}
