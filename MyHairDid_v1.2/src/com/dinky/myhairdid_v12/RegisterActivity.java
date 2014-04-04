package com.dinky.myhairdid_v12;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.SignUpCallback;

public class RegisterActivity extends Activity {

	//Declaring Variables
	private EditText UsernameField;
	private EditText PasswordField;
	private EditText EmailField;
	private TextView ErrorField;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_register);
		//Linking
		UsernameField = (EditText) findViewById(R.id.register_username);
		PasswordField = (EditText) findViewById(R.id.register_password);
		EmailField = (EditText) findViewById(R.id.register_email);
		ErrorField = (TextView) findViewById(R.id.error_messages);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.registration, menu);
		return true;
	}
 //Validation
	public void register(final View v){
		if(UsernameField.getText().length() == 0 || PasswordField.getText().length() == 0|| EmailField.getText().length() == 0)
			return;

		v.setEnabled(false);
		ParseUser user = new ParseUser();
		user.setUsername(UsernameField.getText().toString());
		user.setPassword(PasswordField.getText().toString());
		user.setEmail(EmailField.getText().toString());
		ErrorField.setText("");

		user.signUpInBackground(new SignUpCallback() {
			@Override
			public void done(ParseException e) {
				if (e == null) {
					Intent intent = new Intent(RegisterActivity.this, Launcher.class);
					startActivity(intent);
					finish();
				} else {
					// Sign up didn't succeed. Look at the ParseException
					// to figure out what went wrong
					switch(e.getCode()){
					case ParseException.USERNAME_TAKEN:
						ErrorField.setText("Doh, That name already exists!");
						break;
					case ParseException.USERNAME_MISSING:
						ErrorField.setText("Gotta enter a username first!");
						break;
					case ParseException.PASSWORD_MISSING:
						ErrorField.setText("Passwords are kinda important... Enter one.. A good one!");
						break;
					case ParseException.EMAIL_MISSING:
						ErrorField.setText("Please enter your email too!");
						break;
					default:
						ErrorField.setText(e.getLocalizedMessage());
					}
					v.setEnabled(true);
				}
			}
		});
	}

	public void showLogin(View v) {
		Intent intent = new Intent(this, LoginActivity.class);
		startActivity(intent);
		finish();
	}
}