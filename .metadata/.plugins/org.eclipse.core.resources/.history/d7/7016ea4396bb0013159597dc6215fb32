package com.dinky.myhairdid;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.TextView;

import com.parse.ParseUser;

public class ClientList extends Activity {

	// Declare Variable
	Button logout;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.clientlist);

		// Retrieve current user from Parse.com
		ParseUser currentUser = ParseUser.getCurrentUser();

		// Convert currentUser into String
		String struser = currentUser.getUsername().toString();

		// Locate TextView in welcome.xml
		TextView txtuser = (TextView) findViewById(R.id.txtuser);

		// Set the currentUser String into TextView
		txtuser.setText(struser.toUpperCase());

		// Locate Button in ClientList.xml
		TextView signout = (TextView) findViewById(R.id.signOut);

		// SignOut Click Listener
		signout.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				ParseUser.logOut();
			      Intent intent = new Intent(ClientList.this, Login.class);
			      startActivity(intent);
			      //finish();
			}
		});
	}
}
