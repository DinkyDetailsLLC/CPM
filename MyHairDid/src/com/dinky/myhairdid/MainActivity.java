package com.dinky.myhairdid;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;

import com.parse.Parse;
import com.parse.ParseAnalytics;
import com.parse.ParseObject;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Parse.initialize(this, "whuA5NzWKZoIM1KEDnqnTEpgL2LEvMEZuCFKMYPx", "M7P3slfXFJmHGLm4eX0LKKdi1cOu0GWvxp0hCi2d");
        	
        ParseObject testObject = new ParseObject("TestObject");
        testObject.put("foo", "bar");
        testObject.saveInBackground(); 
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
}
