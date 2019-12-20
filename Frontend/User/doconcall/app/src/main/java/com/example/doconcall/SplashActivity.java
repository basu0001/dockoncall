package com.example.doconcall;

import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

public class SplashActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Thread thread = new Thread() {
            @Override
            public void run() {
                try {
                    sleep(7000);

                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    Intent welcome_Intent = new Intent(SplashActivity.this, WarningActivity.class);
                    startActivity(welcome_Intent);
                }
            }
        };
        thread.start();
    }
    @Override
    protected void onPause()
    {
        super.onPause();
        finish();
    }
}

