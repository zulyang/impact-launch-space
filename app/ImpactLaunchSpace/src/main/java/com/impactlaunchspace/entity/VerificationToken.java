package com.impactlaunchspace.entity;

import java.util.Calendar;
import java.util.Date;
import java.text.SimpleDateFormat;

public class VerificationToken {
  private String verification_code;
  private String username;
  private String expiryDate;
  private static final int EXPIRATION = 60 * 24; //minutes (1day)
    
  public VerificationToken(String verification_code, String username) {
    super();
    this.verification_code = verification_code;
    this.username = username;
    this.expiryDate = calculateExpiryDate();
  }
  
  public VerificationToken(String verification_code, String username, String expiryDate) {
    super();
    this.verification_code = verification_code;
    this.username = username;
    this.expiryDate = expiryDate;
  }

  public String getVerification_code() {
    return verification_code;
  }
  
  public String getUsername() {
    return username;
  }
  
  public String getExpiryDate() {
    return expiryDate;
  }
  
  private String calculateExpiryDate() {
    Calendar now = Calendar.getInstance();
    now.add(Calendar.MINUTE, EXPIRATION);
    Date dt = now.getTime();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String expiry = sdf.format(dt);
    return expiry;
    }

}
