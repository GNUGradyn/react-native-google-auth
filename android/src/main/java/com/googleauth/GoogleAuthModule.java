package com.googleauth;

import androidx.credentials.PublicKeyCredential;
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
import com.google.android.libraries.identity.googleid.GetGoogleIdOption;

import java.util.concurrent.Executors;

@ReactModule(name = GoogleAuthModule.NAME)
public class GoogleAuthModule extends ReactContextBaseJavaModule {
  public static final String NAME = "GoogleAuth";

  CredentialManager credentialManager;
  ReactContext context;

  public GoogleAuthModule(ReactApplicationContext reactContext) {

    super(reactContext);
    context = reactContext;

    credentialManager = CredentialManager.create(getCurrentActivity());

  }

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }

  @ReactMethod
  public void SignInWithGoogle(String clientId, @Nullable String nonce,
                               boolean filterByAuthorizedAccounts, boolean requestVerifiedPhoneNumber,
                               boolean autoSelectEnabled, Promise promise) {
    var googleIdOption = new GetGoogleIdOption.Builder()
      .setServerClientId(clientId)
      .setNonce(nonce)
      .setFilterByAuthorizedAccounts(filterByAuthorizedAccounts)
      .setRequestVerifiedPhoneNumber(requestVerifiedPhoneNumber)
      .setAutoSelectEnabled(autoSelectEnabled)
      .build();

    GetCredentialRequest request = new GetCredentialRequest.Builder()
      .addCredentialOption(googleIdOption)
      .build();

    credentialManager.getCredentialAsync(
      context,
      request,
      new CancellationSignal(),
      Executors.newSingleThreadExecutor(),
      new CredentialManagerCallback<GetCredentialResponse, GetCredentialException>() {
        @Override
        public void onResult(@NonNull GetCredentialResponse result) {
          promise.resolve(result);
        }
        @Override
        public void onError(@NonNull GetCredentialException error) {
          promise.reject(error);
        }
      }
      );
  }
}
