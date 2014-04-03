package com.dinky.myhairdid;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;

import com.parse.ParseAnonymousUtils;
import com.parse.ParseUser;

public class Launcher extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		 // Determine whether the current user is an anonymous user
        if (ParseAnonymousUtils.isLinked(ParseUser.getCurrentUser())) {
            // If user is anonymous, send the user to Login.class
            Intent intent = new Intent(Launcher.this,
                    Login.class);
            startActivity(intent);
            finish();
        } else {
            // If current user is NOT anonymous user
            // Get current user data from Parse.com
            ParseUser currentUser = ParseUser.getCurrentUser();
            if (currentUser != null) {
                // Send logged in users to ClientList.class
                Intent intent = new Intent(Launcher.this, ClientList.class);
                startActivity(intent);
                finish();
            } else {
                // Send user to Register.class
                Intent intent = new Intent(Launcher.this,
                        Register.class);
                startActivity(intent);
                finish();
            }
        }
 
    }
	

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

}
