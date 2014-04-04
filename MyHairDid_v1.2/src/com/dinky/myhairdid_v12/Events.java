package com.dinky.myhairdid_v12;

import com.parse.ParseClassName;
import com.parse.ParseObject;
import com.parse.ParseUser;

//Getter & Setter for the Events Adapter

@ParseClassName("Event")
public class Events extends ParseObject{
	public Events(){

	}

	public boolean isCompleted(){
		return getBoolean("completed");
	}

	public void setCompleted(boolean complete){
		put("completed", complete);
	}

	public String getDescription(){
		return getString("description");
	}

	public void setDescription(String description){
		put("description", description);
	}

	public void setUser(ParseUser currentUser) {
		put("user", currentUser);
	}
}