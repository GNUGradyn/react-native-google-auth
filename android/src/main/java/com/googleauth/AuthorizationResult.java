package com.googleauth;

public class AuthorizationResult {

  public AuthorizationResult (String serverAuthCode, String accessToken, String[] authorizedScopes) {
    this.serverAuthCode = serverAuthCode;
    this.accessToken = accessToken;
    this.authorizedScopes = authorizedScopes;
  }

  public static AuthorizationResult fromGoogleAuthorizationResult(com.google.android.gms.auth.api.identity.AuthorizationResult result) {
    return new AuthorizationResult(result.getServerAuthCode(), result.getAccessToken(), result.getGrantedScopes().toArray(new String[0]));
  }

  public String serverAuthCode;
  public String getServerAuthCode() {return serverAuthCode;}

  public String accessToken;
  public String getAccessToken() {return accessToken;}

  public String[] authorizedScopes;
  public String[] getAuthorizedScopes() {return authorizedScopes;}
}
