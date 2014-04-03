package com.dinky.myhairdid;

import android.app.Application;

import com.parse.Parse;
import com.parse.ParseACL;
import com.parse.ParseUser;

public class MyHairDidApplication extends Application {

	@Override
	public void onCreate() {
		super.onCreate();

		// Initialization code here
		Parse.initialize(this, "whuA5NzWKZoIM1KEDnqnTEpgL2LEvMEZuCFKMYPx",
				"M7P3slfXFJmHGLm4eX0LKKdi1cOu0GWvxp0hCi2d");

		ParseUser.enableAutomaticUser();
		ParseACL defaultACL = new ParseACL();

		defaultACL.setPublicReadAccess(true);

		ParseACL.setDefaultACL(defaultACL, true);
	}

}