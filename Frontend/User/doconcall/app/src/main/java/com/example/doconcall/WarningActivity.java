package com.example.doconcall;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;


public class WarningActivity extends Activity {
    Button button;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // Get the view from activity_main.xml
        setContentView(R.layout.activity_warning);

        // Locate the button in activity_main.xml
        button = (Button) findViewById(R.id.button);

        // Capture button clicks
        button.setOnClickListener(new OnClickListener() {
            public void onClick(View arg0) {

                // Start NewActivity.class
                Intent myIntent = new Intent(WarningActivity.this,
                        LoginActivity.class);
                startActivity(myIntent);
            }
        });
    }

}