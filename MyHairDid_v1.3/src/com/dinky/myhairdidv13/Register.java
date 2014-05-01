package com.dinky.myhairdidv13;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.parse.LogInCallback;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.SignUpCallback;

public class Register extends Activity {

	EditText username, email, password, verifyPassword;
	Button signUp;
	ProgressDialog progressdialog;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.registration);

		init();

		signUp.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (!(API.isInternetOn(Register.this))) {
					showAlert("Internet not avialble.");
				} else {
					progressdialog.setMessage("Please wait...");
					progressdialog.show();
					// Force user to fill up the form
					if (username.getText().toString().equals("")
							|| email.getText().toString().equals("")
							|| password.getText().toString().equals("")
							|| verifyPassword.getText().toString().equals("")) {
						progressdialog.dismiss();
						showAlert("Please complete the sign up form.");
					} else if (!(isValidEmail(email.getText().toString()))) {
						progressdialog.dismiss();
						showAlert("Please enter valid email id.");
					} else if (!(password.getText().toString()
							.equals(verifyPassword.getText().toString()))) {
						progressdialog.dismiss();
						showAlert("Password did not matched");
					} else {
						// Save new user data into Parse.com Data Storage
						ParseUser user = new ParseUser();
						user.setUsername(username.getText().toString());
						user.setPassword(password.getText().toString());
						user.setEmail(email.getText().toString());
						user.signUpInBackground(new SignUpCallback() {
							public void done(ParseException e) {
								if (e == null) {
									AllowUserToLogin(username.getText()
											.toString(), password.getText()
											.toString());
								} else {
									progressdialog.dismiss();
									Toast.makeText(getApplicationContext(),
											"Sign up Error", Toast.LENGTH_LONG)
											.show();
								}
							}
						});
					}
				}
			}
		});
	}

	void init() {
		username = (EditText) findViewById(R.id.username);
		email = (EditText) findViewById(R.id.email);
		password = (EditText) findViewById(R.id.password);
		verifyPassword = (EditText) findViewById(R.id.verifypassword);
		signUp = (Button) findViewById(R.id.signUp);
		progressdialog = new ProgressDialog(Register.this);
	}

	void AllowUserToLogin(String userName, String password) {
		// Send data to Parse.com for verification
		ParseUser.logInInBackground(userName, password, new LogInCallback() {
			public void done(ParseUser user, ParseException e) {
				if (user != null) {
					// If user exist and authenticated, send user to
					// Welcome.class
					Intent intent = new Intent(Register.this, ClientList.class);
					intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK
							| Intent.FLAG_ACTIVITY_CLEAR_TASK);
					startActivity(intent);
					progressdialog.dismiss();
					Toast.makeText(getApplicationContext(),
							"Successfully Logged in", Toast.LENGTH_LONG).show();
					finish();
				} else {
					progressdialog.dismiss();
					showAlert("No such user exist, please signup");
				}
			}
		});
	}

	public final static boolean isValidEmail(CharSequence email) {
		if (email == null) {
			return false;
		} else {
			return android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches();
		}
	}

	void showAlert(String message) {
		new AlertDialog.Builder(Register.this).setTitle("Error")
				.setMessage(message)
				.setPositiveButton("Ok", new DialogInterface.OnClickListener() {

					@Override
					public void onClick(DialogInterface dialog, int which) {
						// TODO Auto-generated method stub

					}
				}).show();
	}
}
