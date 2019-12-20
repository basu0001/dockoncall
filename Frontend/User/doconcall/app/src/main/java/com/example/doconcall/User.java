package com.example.doconcall;

import java.util.Date;


public class User {
    String email_id;
    String firstName;
    Date sessionExpiryDate;

    public void setEmailid(String email_id) {
        this.email_id = email_id;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setSessionExpiryDate(Date sessionExpiryDate) {
        this.sessionExpiryDate = sessionExpiryDate;
    }

    public String getEmailid() {
        return email_id;
    }

    public String getFirstName() {
        return firstName;
    }

    public Date getSessionExpiryDate() {
        return sessionExpiryDate;
    }
}
