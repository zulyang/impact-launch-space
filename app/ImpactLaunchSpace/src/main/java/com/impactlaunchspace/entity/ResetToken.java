package com.impactlaunchspace.entity;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class ResetToken {
  private String reset_code;
  private String username;
  private String expiryDate;
  private static final int EXPIRATION = 60 * 24; //minutes (1day)
    
  public ResetToken(String reset_code, String username) {
    super();
    this.reset_code = reset_code;
    this.username = username;
    this.expiryDate = calculateExpiryDate();
  }
  
  public ResetToken(String reset_code, String username, String expiryDate) {
    super();
    this.reset_code = reset_code;
    this.username = username;
    this.expiryDate = expiryDate;
  }

  public String getReset_code() {
    return reset_code;
  }
  public String getUsername() {
    return username;
  }

  public String getExpiryDate() {
    return expiryDate;
  }
  
  public String calculateExpiryDate() {
    Calendar now = Calendar.getInstance();
    now.add(Calendar.MINUTE, EXPIRATION);
    Date dt = now.getTime();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String expiry = sdf.format(dt);
    return expiry;
    }
}