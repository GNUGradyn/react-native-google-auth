package com.googleauth;

import com.google.android.libraries.identity.googleid.GoogleIdTokenCredential;

public class UserInfo {
  private String givenName;
  private String familyName;
  private String id;
  private String idToken;

  public UserInfo(String givenName, String familyName, String id, String idToken) {
    this.givenName = givenName;
    this.familyName = familyName;
    this.id = id;
    this.idToken = idToken;
  }

  public String getGivenName() {
    return givenName;
  }

  public String getFamilyName() {
    return familyName;
  }

  public String getId() {
    return id;
  }

  public String getIdToken() {
    return idToken;
  }

  @Override
  public String toString() {
    return "UserInfo{" +
      "givenName='" + givenName + '\'' +
      ", familyName='" + familyName + '\'' +
      ", id='" + id + '\'' +
      ", idToken='" + idToken + '\'' +
      '}';
  }

  public static UserInfo ParseGoogleIdTokenCredential(GoogleIdTokenCredential credential) {
    String givenName = credential.getGivenName();
    String familyName = credential.getFamilyName();
    String id = credential.getId();
    String idToken = credential.getIdToken();

    return new UserInfo(givenName, familyName, id, idToken);
  }
}
