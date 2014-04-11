package com.dinky.myhairdid_v12;

import java.util.List;

import android.content.Context;
import android.graphics.Paint;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

//Custom Adapter to handle the rows that get created by the user.

public class EventsAdapter extends ArrayAdapter<Events> {
	private Context Context;
	private List<Events> aEvents;

	public EventsAdapter(Context context, List<Events> objects) {
		super(context, R.layout.event_row_item, objects);
		this.Context = context;
		this.aEvents = objects;
	}

	public View getView(int position, View convertView, ViewGroup parent){
		if(convertView == null){
			LayoutInflater mLayoutInflater = LayoutInflater.from(Context);
			convertView = mLayoutInflater.inflate(R.layout.event_row_item, null);
		}

		Events event = aEvents.get(position);

		TextView descriptionView = (TextView) convertView.findViewById(R.id.event_description);

		descriptionView.setText(event.getDescription());

		if(event.isCompleted()){
			descriptionView.setPaintFlags(descriptionView.getPaintFlags() | Paint.STRIKE_THRU_TEXT_FLAG);
		}else{
			descriptionView.setPaintFlags(descriptionView.getPaintFlags() & (~Paint.STRIKE_THRU_TEXT_FLAG));
		}

		return convertView;
	}

}