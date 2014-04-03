package com.dinky.myhairdid;

import com.parse.Parse;
import com.parse.ParseACL;
 
import com.parse.ParseUser;
 
import android.app.Application;
 
public class ParseApplication extends Application {
 
    @Override
    public void onCreate() {
        super.onCreate();
 
        // Add your initialization code here
        Parse.initialize(this, "whuA5NzWKZoIM1KEDnqnTEpgL2LEvMEZuCFKMYPx", "M7P3slfXFJmHGLm4eX0LKKdi1cOu0GWvxp0hCi2d");
  
        ParseUser.enableAutomaticUser();
        ParseACL defaultACL = new ParseACL();
 
        // If you would like all objects to be private by default, remove this
        // line.
        defaultACL.setPublicReadAccess(true);
 
        ParseACL.setDefaultACL(defaultACL, true);
    }
 
}