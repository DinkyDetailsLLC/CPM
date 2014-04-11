package com.dinky.myhairdidv13;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

public class API {

	public static final boolean isInternetOn(Context c) {
		ConnectivityManager connec = (ConnectivityManager) c
				.getSystemService(Context.CONNECTIVITY_SERVICE);
		// ARE WE CONNECTED TO THE NET
		if (connec.getNetworkInfo(0).getState() == NetworkInfo.State.CONNECTED
				|| connec.getNetworkInfo(1).getState() == NetworkInfo.State.CONNECTED) {
			return true;
		} else if (connec.getNetworkInfo(0).getState() == NetworkInfo.State.DISCONNECTED
				|| connec.getNetworkInfo(1).getState() == NetworkInfo.State.DISCONNECTED) {
			return false;
		}
		return false;
	}

}
