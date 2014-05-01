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

public class Login extends Activity {
	// Declare Variables
	Button loginbutton;
	Button signup;
	String usernametxt;
	String passwordtxt;
	EditText password;
	EditText username;
	ProgressDialog progressdialog;

	/** Called when the activity is first created. */
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_login);

		// Locate EditTexts in activity_login.xml
		username = (EditText) findViewById(R.id.username);
		password = (EditText) findViewById(R.id.password);

		// Initialize dialog
		progressdialog = new ProgressDialog(Login.this);

		// Locate Buttons in activity_login.xml
		loginbutton = (Button) findViewById(R.id.login);
		signup = (Button) findViewById(R.id.signup);

		// Login Button Click Listener
		loginbutton.setOnClickListener(new OnClickListener() {

			public void onClick(View arg0) {

				if (!(API.isInternetOn(Login.this))) {
					showAlert("Internet not avialble.");
				} else {
					progressdialog.setMessage("Please wait...");
					progressdialog.show();

					// Retrieve the text entered from the EditText
					usernametxt = username.getText().toString();
					passwordtxt = password.getText().toString();

					if (usernametxt.equals("")) {
						progressdialog.dismiss();
						showAlert("Please enter username.");
					} else if (passwordtxt.equals("")) {
						progressdialog.dismiss();
						showAlert("Please enter password.");
					} else {
						// Send data to Parse.com for verification
						ParseUser.logInInBackground(usernametxt, passwordtxt,
								new LogInCallback() {
									public void done(ParseUser user,
											ParseException e) {
										if (user != null) {
											// If user exist and authenticated,
											// send
											// user to Welcome.class
											progressdialog.dismiss();
											Intent intent = new Intent(
													Login.this,
													ClientList.class);
											startActivity(intent);
											Toast.makeText(
													getApplicationContext(),
													"Logged in successfully ",
													Toast.LENGTH_LONG).show();
											finish();
										} else {
											progressdialog.dismiss();
											Toast.makeText(
													getApplicationContext(),
													"User not exist, please signup",
													Toast.LENGTH_LONG).show();
										}
									}
								});
					}
				}
			}
		});

		// Sign up Button Click Listener
		signup.setOnClickListener(new OnClickListener() {

			public void onClick(View arg0) {
				// Open Registration Screen for signUp
				startActivity(new Intent(Login.this, Register.class));
			}
		});

	}
	void showAlert(String message) {
		new AlertDialog.Builder(Login.this).setTitle("Error")
				.setMessage(message)
				.setPositiveButton("Ok", new DialogInterface.OnClickListener() {

					@Override
					public void onClick(DialogInterface dialog, int which) {
						// TODO Auto-generated method stub

					}
				}).show();
	}
}