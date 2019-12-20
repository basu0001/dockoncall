package com.example.doconcall;

import androidx.appcompat.app.AppCompatActivity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONException;
import org.json.JSONObject;

public class RegisterActivity extends AppCompatActivity {
    private static final String KEY_STATUS = "status";
    private static final String KEY_MESSAGE = "message";
    private static final String KEY_UID = "UID";
    private static final String KEY_FIRST_NAME = "first_name";
    private static final String KEY_LAST_NAME = "last_name";
    private static final String KEY_EMAIL_ID = "email_id";
    private static final String KEY_CONTACT = "contact";
    private static final String KEY_CONDITION = "condition_acceptance";
    private static final String KEY_BLOOD_GROUP= "blood_group";
    private static final String KEY_QUESTION1 = "Question_1";
    private static final String KEY_QUESTION2 = "Question_2";
    private static final String KEY_QUESTION3 = "Question_3";
    private static final String KEY_QUESTION4 = "Question_4";
    private static final String KEY_PASSWORD = "password";
    private static final String KEY_USER_STATUS = "user_status";
    private static final String KEY_DOB = "dob";
    private static final String KEY_GENDER = "gender";
    private static final String KEY_EMPTY = "";
    private EditText etUID;
    private EditText etFirstName;
    private EditText etLastName;
    private EditText etEmailID;
    private EditText etContact;
    private EditText etCondition;
    private EditText etBloodGroup;
    private EditText etUserStatus;
    private EditText etDob;
    private EditText etGender;
    private EditText etQuestion1;
    private EditText etQuestion2;
    private EditText etQuestion3;
    private EditText etQuestion4;
    private EditText etPassword;
    private EditText etConfirmPassword;

    private String UID;
    private String first_name;
    private String last_name;
    private String email_id;
    private String contact;
    private String condition_acceptance;
    private String blood_group;
    private String Question_1;
    private String Question_2;
    private String Question_3;
    private String Question_4;
    private String user_status;
    private String dob;
    private String password;
    private String confirmPassword;
    private String gender;

    private ProgressDialog pDialog;
    private String register_url = "http://192.168.43.186/backend/register.php";
    private SessionHandler session;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        session = new SessionHandler(getApplicationContext());
        setContentView(R.layout.activity_register);

        etUID = findViewById(R.id.etUID);
        etFirstName = findViewById(R.id.etFirstName);
        etLastName= findViewById(R.id.etLastName);
        etEmailID = findViewById(R.id.etEmailID);
        etContact = findViewById(R.id.etContact);
        etCondition = findViewById(R.id.etCondition);
        etBloodGroup = findViewById(R.id.etBloodGroup);
        etUserStatus = findViewById(R.id.etUserStatus);
        etDob = findViewById(R.id.etDob);
        etGender = findViewById(R.id.etGender);
        etQuestion1 = findViewById(R.id.etQuestion1);
        etQuestion2 = findViewById(R.id.etQuestion2);
        etQuestion3 = findViewById(R.id.etQuestion3);
        etQuestion4 = findViewById(R.id.etQuestion4);
        etPassword = findViewById(R.id.etPassword);
        etConfirmPassword = findViewById(R.id.etConfirmPassword);


        Button login = findViewById(R.id.btnRegisterLogin);
        Button register = findViewById(R.id.btnRegister);

        //Launch Login screen when Login Button is clicked
        login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(RegisterActivity.this, LoginActivity.class);
                startActivity(i);
                finish();
            }
        });

        register.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //Retrieve the data entered in the edit texts
                UID = etUID.getText().toString().trim();
                first_name = etFirstName.getText().toString().trim();
                last_name = etLastName.getText().toString().trim();
                email_id = etEmailID.getText().toString().trim();
                contact = etContact.getText().toString();
                condition_acceptance = etCondition.getText().toString().trim();
                blood_group = etBloodGroup.getText().toString().trim();
                user_status = etUserStatus.getText().toString().trim();
                dob = etDob.getText().toString();
                gender = etGender.getText().toString().trim();
                Question_1 = etQuestion1.getText().toString().trim();
                Question_2 = etQuestion2.getText().toString().trim();
                Question_3 = etQuestion3.getText().toString().trim();
                Question_4 = etQuestion4.getText().toString().trim();
                password = etPassword.getText().toString().trim();
                confirmPassword = etConfirmPassword.getText().toString().trim();

                if (validateInputs()) {
                    registerUser();
                }

            }
        });

    }

    /**
     * Display Progress bar while registering
     */
    private void displayLoader() {
        pDialog = new ProgressDialog(RegisterActivity.this);
        pDialog.setMessage("Signing Up.. Please wait...");
        pDialog.setIndeterminate(false);
        pDialog.setCancelable(false);
        pDialog.show();

    }

    /**
     * Launch Dashboard Activity on Successful Sign Up
     */
    private void loadDashboard() {
        Intent i = new Intent(getApplicationContext(), DashboardActivity.class);
        startActivity(i);
        finish();

    }

    private void registerUser() {
        displayLoader();
        JSONObject request = new JSONObject();
        try {
            //Populate the request parameters
            request.put(KEY_UID, UID);
            request.put(KEY_FIRST_NAME, first_name);
            request.put(KEY_LAST_NAME, last_name);
            request.put(KEY_EMAIL_ID, email_id);
            request.put(KEY_CONTACT, contact);
            request.put(KEY_CONDITION, condition_acceptance );
            request.put(KEY_BLOOD_GROUP, blood_group);
            request.put(KEY_QUESTION1, Question_1);
            request.put(KEY_QUESTION2, Question_2);
            request.put(KEY_QUESTION3, Question_3);
            request.put(KEY_QUESTION4, Question_4);
            request.put(KEY_USER_STATUS, user_status);
            request.put(KEY_DOB, dob);
            request.put(KEY_PASSWORD, password);
            request.put(KEY_GENDER, gender);

        } catch (JSONException e) {
            e.printStackTrace();
        }
        JsonObjectRequest jsArrayRequest = new JsonObjectRequest
                (Request.Method.POST, register_url, request, new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        pDialog.dismiss();
                        try {
                            //Check if user got registered successfully
                            if (response.getInt(KEY_STATUS) == 0) {
                                //Set the user session
                                session.loginUser(email_id,first_name);
                                loadDashboard();

                            }else if(response.getInt(KEY_STATUS) == 1){
                                //Display error message if username is already existsing
                                etEmailID.setError("Email Address already taken!");
                                etEmailID.requestFocus();

                            }else{
                                Toast.makeText(getApplicationContext(),
                                        response.getString(KEY_MESSAGE), Toast.LENGTH_SHORT).show();

                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }
                }, new Response.ErrorListener() {

                    @Override
                    public void onErrorResponse(VolleyError error) {
                        pDialog.dismiss();

                        //Display error message whenever an error occurs
                        Toast.makeText(getApplicationContext(),
                                error.getMessage(), Toast.LENGTH_SHORT).show();

                    }
                });

        // Access the RequestQueue through your singleton class.
        MySingleton.getInstance(this).addToRequestQueue(jsArrayRequest);
    }

    /**
     * Validates inputs and shows error if any
     * @return
     */
    private boolean validateInputs() {
        if (KEY_EMPTY.equals(UID)) {
            etUID.setError("UID cannot be empty");
            etUID.requestFocus();
            return false;

        }
        if (KEY_EMPTY.equals(first_name)) {
            etFirstName.setError("First name cannot be empty");
            etFirstName.requestFocus();
            return false;
        }
        if (KEY_EMPTY.equals(last_name)) {
            etLastName.setError("Last Name cannot be empty");
            etLastName.requestFocus();
            return false;

        }
        if (KEY_EMPTY.equals(email_id)) {
            etEmailID.setError("EmailID cannot be empty");
            etEmailID.requestFocus();
            return false;

        }
        if (KEY_EMPTY.equals(contact)) {
            etContact.setError("Contact cannot be empty");
            etContact.requestFocus();
            return false;

        }
        if (KEY_EMPTY.equals(condition_acceptance)) {
            etCondition.setError("condition_acceptance cannot be empty");
            etCondition.requestFocus();
            return false;

        }
        if (KEY_EMPTY.equals(blood_group)) {
            etBloodGroup.setError("Blood group cannot be empty");
            etBloodGroup.requestFocus();
            return false;

        }
        if (KEY_EMPTY.equals(user_status)) {
            etUserStatus.setError("user status cannot be empty");
            etUserStatus.requestFocus();
            return false;

        }
        if (KEY_EMPTY.equals(dob)) {
            etDob.setError("DOB cannot be empty");
            etDob.requestFocus();
            return false;

        }
        if (KEY_EMPTY.equals(gender)) {
            etGender.setError("Gender cannot be empty");
            etGender.requestFocus();
            return false;

        }
        if (KEY_EMPTY.equals(Question_1)) {
            etQuestion1.setError("Question_1 cannot be empty");
            etQuestion1.requestFocus();
            return false;

        }


        if (KEY_EMPTY.equals(Question_2)) {
            etQuestion2.setError("Question 2 cannot be empty");
            etQuestion2.requestFocus();
            return false;

        }
        if (KEY_EMPTY.equals(Question_3)) {
            etQuestion3.setError("Question_3 cannot be empty");
            etQuestion3.requestFocus();
            return false;

        }
        if (KEY_EMPTY.equals(Question_4)) {
            etQuestion4.setError("Question 4  cannot be empty");
            etQuestion4.requestFocus();
            return false;

        }

        if (KEY_EMPTY.equals(password)) {
            etPassword.setError("Password cannot be empty");
            etPassword.requestFocus();
            return false;
        }

        if (KEY_EMPTY.equals(confirmPassword)) {
            etConfirmPassword.setError("Confirm Password cannot be empty");
            etConfirmPassword.requestFocus();
            return false;
        }
        if (!password.equals(confirmPassword)) {
            etConfirmPassword.setError("Password and Confirm Password does not match");
            etConfirmPassword.requestFocus();
            return false;
        }

        return true;
    }
}

