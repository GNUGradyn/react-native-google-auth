package com.googleauth;

import static androidx.core.app.ActivityCompat.startIntentSenderForResult;

import androidx.credentials.exceptions.GetCredentialException;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Intent;
import android.content.IntentSender;
import android.os.CancellationSignal;

import androidx.credentials.CredentialManagerCallback;
import androidx.credentials.GetCredentialRequest;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.credentials.CredentialManager;
import androidx.credentials.GetCredentialResponse;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.google.android.gms.auth.api.identity.AuthorizationRequest;
import com.google.android.gms.auth.api.identity.AuthorizationResult;
import com.google.android.gms.auth.api.identity.Identity;
import com.google.android.gms.common.api.ApiException;
import com.google.android.gms.common.api.Scope;
import com.google.android.libraries.identity.googleid.GetSignInWithGoogleOption;
import com.google.android.libraries.identity.googleid.GoogleIdTokenCredential;
import com.google.gson.Gson;

import java.util.Arrays;
import java.util.concurrent.Executors;

@ReactModule(name = GoogleAuthModule.NAME)
public class GoogleAuthModule extends ReactContextBaseJavaModule implements ActivityEventListener {
  public static final String NAME = "GoogleAuth";
  public static final int REQUEST_AUTHORIZE = 1001;

  private CredentialManager credentialManager = null;
  private Promise authorizationPromise;

  public GoogleAuthModule(ReactApplicationContext reactContext) {
    super(reactContext);
    reactContext.addActivityEventListener(this);
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

    GetSignInWithGoogleOption googleIdOption = new GetSignInWithGoogleOption(clientId, hostedDomainFilter, nonce);

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
          GoogleIdTokenCredential googleIdTokenCredential = GoogleIdTokenCredential.createFrom(result.getCredential().getData());
          promise.resolve(new Gson().toJson(UserInfo.ParseGoogleIdTokenCredential(googleIdTokenCredential)));
        }

        @Override
        public void onError(@NonNull GetCredentialException error) {
          promise.reject(error);
        }
      });
  }

  @ReactMethod
  public void AuthorizeWithGoogle(String[] scopes, Promise promise) {
    authorizationPromise = promise;
    AuthorizationRequest authorizationRequest = AuthorizationRequest.builder().setRequestedScopes(Arrays.stream(scopes).map(x -> new Scope(x)).toList()).build();
    Identity.getAuthorizationClient(getCurrentActivity())
      .authorize(authorizationRequest)
      .addOnSuccessListener(
        authorizationResult -> {
          if (authorizationResult.hasResolution()) {
            PendingIntent pendingIntent = authorizationResult.getPendingIntent();
            try {
              startIntentSenderForResult(getCurrentActivity(), pendingIntent.getIntentSender(),
                REQUEST_AUTHORIZE, null, 0, 0, 0, null);
            } catch (IntentSender.SendIntentException e) {
              promise.reject("Failed to authorize with google", e);
            }
          } else {
            promise.resolve(authorizationResult);
          }
        })
      .addOnFailureListener(e -> promise.reject("Failed to authorize with google", e));

  }

  @Override
  public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
    if (requestCode == REQUEST_AUTHORIZE) {
      try {
        AuthorizationResult authorizationResult = Identity.getAuthorizationClient(getCurrentActivity()).getAuthorizationResultFromIntent(data);
        authorizationPromise.resolve(authorizationResult);
      } catch (ApiException e) {
        authorizationPromise.reject("Failed to authorize with google", e);
      }

    }
  }

  @Override
  public void onNewIntent(Intent intent) {

  }
}
