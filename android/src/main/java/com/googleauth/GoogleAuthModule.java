package com.googleauth;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.credentials.CredentialManager;
import androidx.credentials.GetCredentialRequest;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.google.android.libraries.identity.googleid.GetGoogleIdOption;

@ReactModule(name = GoogleAuthModule.NAME)
public class GoogleAuthModule extends ReactContextBaseJavaModule {
  public static final String NAME = "GoogleAuth";

  CredentialManager credentialManager;

  public GoogleAuthModule(ReactApplicationContext reactContext) {

    super(reactContext);

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

    credentialManager.getCredentialAsync(getCurrentActivity(), googleIdOption);
  }
}
