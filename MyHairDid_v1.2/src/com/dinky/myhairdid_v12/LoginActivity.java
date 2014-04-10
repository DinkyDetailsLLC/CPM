package com.dinky.myhairdid_v12;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.parse.LogInCallback;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.dinky.myhairdid_v12.checkForNetworkConnection;

public class LoginActivity extends Activity {

	private EditText UsernameField;
	private EditText PasswordField;
	private TextView ErrorField;
	
	//bool to see if internet is present
    Boolean isInternetPresent = false;
     
    // interfacing the class
    checkForNetworkConnection nc;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_login);

		UsernameField = (EditText) findViewById(R.id.login_username);
		PasswordField = (EditText) findViewById(R.id.login_password);
		ErrorField = (TextView) findViewById(R.id.error_messages);
		
		//instance for connection
		 nc = new checkForNetworkConnection(getApplicationContext());
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.login, menu);
		return true;
	}
	
	

	public void signIn(final View v){
		v.setEnabled(false);
		ParseUser.logInInBackground(UsernameField.getText().toString(), PasswordField.getText().toString(), new LogInCallback() {
			@Override
			public void done(ParseUser user, ParseException e) {
				if (user != null) {
					Intent intent = new Intent(LoginActivity.this, Launcher.class);
					startActivity(intent);
					//finish();
				} else {
					// Signup failed. Look at the ParseException to see what happened.
					switch(e.getCode()){
					case ParseException.USERNAME_TAKEN:
						ErrorField.setText("Doh, That name already exists!");
						break;
					case ParseException.USERNAME_MISSING:
						ErrorField.setText("Gotta enter a username first!");
						break;
					case ParseException.PASSWORD_MISSING:
						ErrorField.setText("Wrong Answer... Try again...");
						break;
					case ParseException.OBJECT_NOT_FOUND:
						ErrorField.setText("Sorry, those credentials were invalid.");
						break;
					default:
						ErrorField.setText(e.getLocalizedMessage());
						break;
					}
					v.setEnabled(true);
				}
			}
		});
	}

	public void showRegistration(View v) {
		Intent intent = new Intent(this, RegisterActivity.class);
		startActivity(intent);
		finish();
	}
	
	
    //Function to display simple Alert Dialog
    public void showAlertDialog(Context context, String title, String message, Boolean status) {
        AlertDialog alertDialog = new AlertDialog.Builder(context).create();
 
        // Setting Dialog Title
        alertDialog.setTitle(title);
 
        // Setting Dialog Message
        alertDialog.setMessage(message);
         
        // Showing Alert Message
        alertDialog.show();
    }

	
}