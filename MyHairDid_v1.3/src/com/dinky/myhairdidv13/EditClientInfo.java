package com.dinky.myhairdidv13;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import com.parse.GetCallback;
import com.parse.ParseException;
import com.parse.ParseFile;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;
import com.parse.SaveCallback;

import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class EditClientInfo extends Activity {

	private static final int ACTION_REQUEST_GALLERY = 99;
	private static final int ACTION_REQUEST_FEATHER = 100;
	private static final int EXTERNAL_STORAGE_UNAVAILABLE = 1;
	// Activity request codes
	private static final int CAMERA_CAPTURE_IMAGE_REQUEST_CODE = 200;
	public static final int MEDIA_TYPE_IMAGE = 1;
	/** Folder name on the sdcard where the images will be saved **/
	private static final String FOLDER_NAME = "TEST";

	EditText et_name, et_address, et_city, et_state, et_zip, et_phone,
			et_email;
	String client_name, client_add, client_city, client_state, client_email,
			object_id, client_phone, client_zip;
	Button btn_edit, btn_upload;
	ProgressDialog mProgressDlg;
	Bitmap mBitmapPic;
	boolean mFlgChangePic;

	String mOutputFilePath;
	Uri mImageUri;
	int imageWidth, imageHeight;

	boolean save_edit = false;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.edit_client_info);

		et_name = (EditText) findViewById(R.id.add_client_et_name);
		et_address = (EditText) findViewById(R.id.add_client_et_address);
		et_city = (EditText) findViewById(R.id.add_client_et_city);
		et_state = (EditText) findViewById(R.id.add_client_et_state);
		et_zip = (EditText) findViewById(R.id.add_client_et_zip);
		et_phone = (EditText) findViewById(R.id.add_client_et_phone);
		et_email = (EditText) findViewById(R.id.add_client_et_email);

		btn_edit = (Button) findViewById(R.id.add_client_btnEdit);
		btn_upload = (Button) findViewById(R.id.add_client_bt_upload);

		Intent intent = getIntent();

		client_name = intent.getStringExtra("name");
		client_add = intent.getStringExtra("add");
		client_city = intent.getStringExtra("city");
		client_state = intent.getStringExtra("state");
		client_email = intent.getStringExtra("email");
		client_phone = intent.getStringExtra("phone");
		client_zip = intent.getStringExtra("zip");

		object_id = intent.getStringExtra("objectId");

		et_name.setText(client_name);
		et_address.setText(client_add);
		et_city.setText(client_city);
		et_state.setText(client_state);
		et_zip.setText(String.valueOf(client_zip));
		et_phone.setText(String.valueOf(client_phone));
		et_email.setText(client_email);
		// et_name.setText(client_name);

		et_name.setEnabled(false);
		et_address.setEnabled(false);
		et_city.setEnabled(false);
		et_state.setEnabled(false);
		et_zip.setEnabled(false);
		et_phone.setEnabled(false);
		et_email.setEnabled(false);
		btn_upload.setEnabled(false);

		btn_edit.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (!save_edit) {
					et_name.setEnabled(true);
					et_address.setEnabled(true);
					et_city.setEnabled(true);
					et_state.setEnabled(true);
					et_zip.setEnabled(true);
					et_phone.setEnabled(true);
					et_email.setEnabled(true);
					btn_upload.setEnabled(true);
					btn_edit.setText("Save");
					save_edit = true;
				} else {
					validateForm();
				}

			}
		});

		((Button) findViewById(R.id.add_client_bt_upload))
				.setOnClickListener(new OnClickListener() {

					@Override
					public void onClick(View v) {
						// TODO Auto-generated method stub
						// custom dialog
						final Dialog dialog = new Dialog(EditClientInfo.this);
						dialog.setContentView(R.layout.dialog_pic_selection);
						dialog.setTitle("Title...");

						// set the custom dialog components - text, image and
						// button
						((Button) dialog.findViewById(R.id.dialog_bt_gallery))
								.setOnClickListener(new OnClickListener() {

									@Override
									public void onClick(View v) {
										// TODO Auto-generated method stub
										pickFromGallery();
									}
								});
						// ((Button) dialog.findViewById(R.id.dialog_bt_camera))
						// .setOnClickListener(new OnClickListener() {
						//
						// @Override
						// public void onClick(View v) {
						// // TODO Auto-generated method stub
						// captureImage();
						// }
						// });
						dialog.show();
					}
				});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.edit_client_info, menu);
		return true;
	}

	/**
	 * Start the activity to pick an image from the user gallery
	 */
	private void pickFromGallery() {
		Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
		intent.setType("image/*");

		Intent chooser = Intent.createChooser(intent, "Choose a Picture");
		startActivityForResult(chooser, ACTION_REQUEST_GALLERY);
	}

	/*
	 * Capturing Camera Image will lauch camera app requrest image capture
	 */
	private void captureImage() {
		Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);

		mImageUri = getOutputMediaFileUri(MEDIA_TYPE_IMAGE);

		intent.putExtra(MediaStore.EXTRA_OUTPUT, mImageUri);

		// start the image capture Intent
		startActivityForResult(intent, CAMERA_CAPTURE_IMAGE_REQUEST_CODE);
	}

	/*
	 * Creating file uri to store image/video
	 */
	public Uri getOutputMediaFileUri(int type) {
		return Uri.fromFile(getOutputMediaFile(type));
	}

	/*
	 * Here we store the file url as it will be null after returning from camera
	 * app
	 */
	@Override
	protected void onSaveInstanceState(Bundle outState) {
		super.onSaveInstanceState(outState);

		// save file url in bundle as it will be null on scren orientation
		// changes
		outState.putParcelable("file_uri", mImageUri);
	}

	@Override
	protected void onRestoreInstanceState(Bundle savedInstanceState) {
		super.onRestoreInstanceState(savedInstanceState);

		// get the file url
		mImageUri = savedInstanceState.getParcelable("file_uri");
	}

	/*
	 * returning image / video
	 */
	private static File getOutputMediaFile(int type) {

		// External sdcard location
		File mediaStorageDir = new File(
				Environment
						.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),
				FOLDER_NAME);

		// Create the storage directory if it does not exist
		if (!mediaStorageDir.exists()) {
			if (!mediaStorageDir.mkdirs()) {
				Log.d(FOLDER_NAME, "Oops! Failed create " + FOLDER_NAME
						+ " directory");
				return null;
			}
		}

		// Create a media file name
		String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss",
				Locale.getDefault()).format(new Date());
		File mediaFile;
		if (type == MEDIA_TYPE_IMAGE) {
			mediaFile = new File(mediaStorageDir.getPath() + File.separator
					+ "IMG_" + timeStamp + ".jpg");
		} else {
			return null;
		}

		return mediaFile;
	}

	@Override
	/**
	 * This method is called when feather has completed ( ie. user clicked on "done" or just exit the activity without saving ). <br />
	 * If user clicked the "done" button you'll receive RESULT_OK as resultCode, RESULT_CANCELED otherwise.
	 * 
	 * @param requestCode
	 * 	- it is the code passed with startActivityForResult
	 * @param resultCode
	 * 	- result code of the activity launched ( it can be RESULT_OK or RESULT_CANCELED )
	 * @param data
	 * 	- the result data
	 */
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		if (resultCode == RESULT_OK) {
			switch (requestCode) {

			case CAMERA_CAPTURE_IMAGE_REQUEST_CODE:
				// user chose an image from the gallery
				if (resultCode == RESULT_OK) {
					// successfully captured the image
					// display it in image view
					previewCapturedImage();
				} else if (resultCode == RESULT_CANCELED) {
					// user cancelled Image capture
					Toast.makeText(getApplicationContext(),
							"User cancelled image capture", Toast.LENGTH_SHORT)
							.show();
				} else {
					// failed to capture image
					Toast.makeText(getApplicationContext(),
							"Sorry! Failed to capture image",
							Toast.LENGTH_SHORT).show();
				}
				break;

			case ACTION_REQUEST_GALLERY:
				// user chose an image from the gallery
				// loadAsync(data.getData());
				mFlgChangePic = true;
				mImageUri = data.getData();
				previewCapturedImage();
				break;

			}
		}
	}

	/*
	 * Display image from a path to ImageView
	 */
	private void previewCapturedImage() {
		try {
			// bimatp factory
			mFlgChangePic = true;
			// BitmapFactory.Options options = new BitmapFactory.Options();
			//
			// // downsizing image as it throws OutOfMemory Exception for larger
			// // images
			// options.inSampleSize = 8;
			//
			// final Bitmap bitmap =
			// BitmapFactory.decodeFile(mImageUri.getPath(),
			// options);
			//
			// mBitmapPic = bitmap;
			try {
				mBitmapPic = MediaStore.Images.Media.getBitmap(
						this.getContentResolver(), mImageUri);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// mImage.setImageBitmap(bitmap);
		} catch (NullPointerException e) {
			e.printStackTrace();
		}
	}

	void updateStory() {

		mProgressDlg = ProgressDialog.show(this, "Please wait...",
				"Updating Info...", true);

		client_name = et_name.getText().toString();
		client_add = et_address.getText().toString();
		client_city = et_city.getText().toString();
		client_state = et_state.getText().toString();
		client_email = et_email.getText().toString();
		client_phone = et_phone.getText().toString();
		client_zip = et_zip.getText().toString();

		System.out.println(client_name + "  " + client_add + "  " + client_city
				+ "  " + client_state + "  " + client_email + "  "
				+ client_phone + "  " + client_zip);

		ParseQuery<ParseObject> query = ParseQuery.getQuery("ClientDetail");

		// Retrieve the object by id
		query.getInBackground(object_id, new GetCallback<ParseObject>() {
			public void done(ParseObject newStatus, ParseException e) {
				if (e == null) {
					// Now let's update it with some new data. In this case,
					// only cheatMode and score
					// will get sent to the Parse Cloud. playerName hasn't
					// changed.
					newStatus.put("name", client_name);
					newStatus.put("type", "status");

					// newStatus.put("name", client_name);
					newStatus.put("address", client_add);
					newStatus.put("city", client_city);
					newStatus.put("email", client_email);
					newStatus.put("phone", client_phone);
					newStatus.put("state", client_state);
					newStatus.put("zip", client_zip);

					if (mFlgChangePic) {
						System.gc();

						Log.e("Bitmap on image post:-->>", "" + mBitmapPic);
						if (mBitmapPic != null) {
							ByteArrayOutputStream stream = new ByteArrayOutputStream();
							mBitmapPic.compress(Bitmap.CompressFormat.JPEG, 90,
									stream);
							byte[] byteArray = stream.toByteArray();

							newStatus.put("image", new ParseFile(byteArray));
						} else {

						}
					}
					newStatus.saveEventually();
					newStatus.saveInBackground(new SaveCallback() {

						@Override
						public void done(ParseException e) {
							// TODO Auto-generated method stub

							if (e == null) {
								mProgressDlg.dismiss();

								Intent intent = new Intent(EditClientInfo.this,
										ClientList.class);
								intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
								startActivity(intent);
								finish();
							} else {
								mProgressDlg.dismiss();
								AlertDialog.Builder builder = new AlertDialog.Builder(
										EditClientInfo.this);
								builder.setTitle("Error");
								builder.setMessage("Data will be updated when u will be connected to internet on server");
								builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
									
									@Override
									public void onClick(DialogInterface dialog, int which) {
										// TODO Auto-generated method stub
										dialog.dismiss();
										finish();
									}
								});
								builder.show();
							}

							// overridePendingTransition(R.anim.mainfadein,
							// R.anim.splashfadeout);ss
						}
					});
				}
			}
		});

	}

	void validateForm() {

		client_name = et_name.getText().toString();
		client_add = et_address.getText().toString();
		client_city = et_city.getText().toString();
		client_state = et_state.getText().toString();
		client_email = et_email.getText().toString();
		client_phone = et_phone.getText().toString();
		client_zip = et_zip.getText().toString();

		if (client_name.length() <= 0) {
			Toast.makeText(this, "Please enter name", Toast.LENGTH_SHORT)
					.show();
		} else if (client_add.length() <= 0) {
			Toast.makeText(this, "Please enter address", Toast.LENGTH_SHORT)
					.show();
		} else if (client_city.length() <= 0) {
			Toast.makeText(this, "Please enter city", Toast.LENGTH_SHORT)
					.show();
		} else if (client_state.length() <= 0) {
			Toast.makeText(this, "Please enter state", Toast.LENGTH_SHORT)
					.show();
		} else if (!(isValidEmail(et_email.getText().toString()))) {
			Toast.makeText(getApplicationContext(),
					"Please enter valid email id.", Toast.LENGTH_LONG).show();
		} else if (et_phone.getText().toString().length() <= 0) {
			Toast.makeText(this, "Please enter contact number",
					Toast.LENGTH_SHORT).show();
		} else if (et_zip.getText().toString().length() <= 0
				&& et_zip.getText().toString().length() == 6) {
			Toast.makeText(this, "zip code entred is not correct",
					Toast.LENGTH_SHORT).show();
		} else {
			updateStory();
		}
	}

	public final static boolean isValidEmail(CharSequence email) {
		if (email == null) {
			return false;
		} else {
			return android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches();
		}
	}

}