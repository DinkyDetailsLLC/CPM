package com.dinky.myhairdidv13;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView.OnItemLongClickListener;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

import utils.BudsCustomAdapter;

import com.parse.DeleteCallback;
import com.parse.ParseUser;
import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseFile;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

public class ClientList extends Activity implements View.OnClickListener {

	ArrayList<Object> mDataList;
	ArrayList<String> mClientImages;
	ArrayList<String> mClientName;
	ArrayList<String> mClientEmail;
	ArrayList<String> mClientAddress;
	ArrayList<String> mClientCity;
	ArrayList<String> mClientstate;
	ArrayList<String> mClientzip;
	ArrayList<String> mClientphone;
	BudsCustomAdapter mListAdapter;

	ListView lv_clientDetail;

	// Declare Variable
	Button logout;

	ArrayList<ParseObject> objectId;
	ArrayList<String> objectId_str;

	ProgressDialog mprogressDialog;

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

		mprogressDialog = new ProgressDialog(ClientList.this);

		lv_clientDetail = (ListView) findViewById(R.id.listView_clientList);

		mDataList = new ArrayList<Object>();
		mClientImages = new ArrayList<String>();
		mClientName = new ArrayList<String>();
		mClientEmail = new ArrayList<String>();
		mClientAddress = new ArrayList<String>();
		mClientCity = new ArrayList<String>();
		mClientstate = new ArrayList<String>();
		mClientzip = new ArrayList<String>();
		mClientphone = new ArrayList<String>();

		objectId = new ArrayList<ParseObject>();
		objectId_str = new ArrayList<String>();

		getStories();

		// Locate Button in ClientList.xml
		TextView signout = (TextView) findViewById(R.id.signOut);
		signout.setOnClickListener(this);

		// Locate Button in ClientList.xml
		TextView add = (TextView) findViewById(R.id.add);
		add.setOnClickListener(this);

		lv_clientDetail.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View v, int pos,
					long id) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(ClientList.this,
						EditClientInfo.class);
				intent.putExtra("name", mClientName.get(pos));
				intent.putExtra("add", mClientAddress.get(pos));
				intent.putExtra("city", mClientCity.get(pos));
				intent.putExtra("state", mClientstate.get(pos));
				intent.putExtra("zip", mClientzip.get(pos));
				intent.putExtra("email", mClientEmail.get(pos));
				intent.putExtra("phone", mClientphone.get(pos));
				intent.putExtra("imageUrl", mClientImages.get(pos));
				intent.putExtra("objectId", objectId_str.get(pos));
				System.out.println("mClientphone.get(pos)"
						+ mClientphone.get(pos) + "  " + mClientzip.get(pos));

				startActivity(intent);
			}
		});

		lv_clientDetail
				.setOnItemLongClickListener(new OnItemLongClickListener() {

					@Override
					public boolean onItemLongClick(AdapterView<?> arg0,
							View arg1, final int position, long arg3) {
						// TODO Auto-generated method stub
						new AlertDialog.Builder(ClientList.this)
								.setMessage(
										"Are you sure you want to delete this client?")
								.setPositiveButton("Ok",
										new DialogInterface.OnClickListener() {

											@Override
											public void onClick(
													DialogInterface dialog,
													int which) {
												// TODO Auto-generated method
												// stub
												dialog.dismiss();
												deleteUser(objectId
														.get(position));
											}
										})
								.setNegativeButton("Cancel",
										new DialogInterface.OnClickListener() {

											@Override
											public void onClick(
													DialogInterface dialog,
													int which) {
												// TODO Auto-generated method
												// stub
												dialog.dismiss();
											}
										}).show();

						return true;
					}
				});
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		switch (v.getId()) {
		case R.id.add:
			Intent intent = new Intent(ClientList.this, AddClientInfo.class);
			intent.putExtra("mode", "newAdd");
			startActivity(intent);
			break;
		case R.id.signOut:
			ParseUser.logOut();
			Intent intent2 = new Intent(ClientList.this, Login.class);
		//	intent2.putExtra("mode", "newAdd");
			startActivity(intent2);
			//finish();
			break;
		}
	}

	public void getStories() {

		mprogressDialog.setMessage("Loading...");
		mprogressDialog.show();

		ParseQuery<ParseObject> query = ParseQuery.getQuery("ClientDetail");
		query.whereEqualTo("Admin", ParseUser.getCurrentUser().getUsername());
//		query.whereEqualTo("type", "status");

		query.findInBackground(new FindCallback<ParseObject>() {
			@Override
			public void done(List<ParseObject> storyList, ParseException e) {
				// Log.e("###ARRAY SIZE 22222", ""+arrayList.size());
				if (e == null) {
					Log.d("score", "Retrieved " + storyList.size() + " scores");

					for (int i = 0; i < storyList.size(); i++) {
						mDataList.add(storyList.get(i));

						Log.e("Story", "" + mDataList);
					}

					// Log.e("$$$ARRAY SIZE 3333", ""+mDataList.size());

					for (ParseObject o : storyList) {

						ParseFile image = o.getParseFile("image");
						String client_name = o.getString("name");
						String Client_email = o.getString("email");
						String Client_add = o.getString("address");
						String Client_city = o.getString("city");
						String Client_phone = o.getString("phone");
						String Client_state = o.getString("state");
						String Client_zip = o.getString("zip");

						String objectId = o.getObjectId();

						Log.e("ObjectId:-->>>", "" + objectId
								+ "Parse Object:--" + o);
						ClientList.this.objectId.add(o);
						objectId_str.add(objectId);

						String story = o.getObjectId();

						if (image != null) {
							String url = image.getUrl();
							Log.e("url in resume", "" + url);
							mClientImages.add(url);

						} else {
							Log.e("empty url in resume", "empty");
							mClientImages.add("empty");
							// do nothing
						}

						mClientName.add(client_name);
						mClientAddress.add(Client_add);
						mClientCity.add(Client_city);
						mClientEmail.add(Client_email);
						mClientphone.add(Client_phone);
						mClientzip.add(Client_zip);
						mClientstate.add(Client_state);
					}
					// Log.v("array in profile size", ""+arrayList.size());

					mListAdapter = new BudsCustomAdapter(ClientList.this,
							mClientName, mClientImages);
					lv_clientDetail.setAdapter(mListAdapter);

					mprogressDialog.dismiss();
					// }
				} else {
					Log.d("score", "Error: " + e.getMessage());
				}
			}
		});
	}

	void deleteUser(ParseObject objectid) {

		mprogressDialog.setMessage("Please wait...");
		mprogressDialog.show();
		objectid.deleteEventually(new DeleteCallback() {

			@Override
			public void done(ParseException e) {
				// TODO Auto-generated method stub
				if (e == null) {
					mprogressDialog.dismiss();
					openView();
				} else {
					mprogressDialog.dismiss();
					AlertDialog.Builder builder = new AlertDialog.Builder(
							ClientList.this);
					builder.setTitle("Error");
					builder.setMessage(e.getMessage());
					builder.setPositiveButton("OK", null);
					builder.show();
				}

			}
		});
	}

	void openView() {
		startActivity(new Intent(this, ClientList.class)
				.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP));
		finish();
	}

	void showAlert(String message) {
		new AlertDialog.Builder(ClientList.this).setTitle("Error")
				.setMessage(message)
				.setPositiveButton("Ok", new DialogInterface.OnClickListener() {

					@Override
					public void onClick(DialogInterface dialog, int which) {
						// TODO Auto-generated method stub

					}
				}).show();
	}
}

