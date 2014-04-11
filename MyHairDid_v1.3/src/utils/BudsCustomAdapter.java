package utils;

import java.util.ArrayList;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.dinky.myhairdidv13.R;

public class BudsCustomAdapter extends BaseAdapter {

	private Activity activity;

	String mUserName;
	boolean mProfilePrivate;
	ImageView btn_groupName;

	// Bitmap bmp;
	// Bitmap bitmap1;
	static int pos;
	ViewHolder viewHolder;

	private static LayoutInflater inflater = null;
	ArrayList<String> aClientName = new ArrayList<String>();
	ArrayList<String> aClientImageUrl = new ArrayList<String>();

	public BudsCustomAdapter(Activity a, ArrayList<String> budsname,
			ArrayList<String> image_url) {
		this.activity = a;
		this.aClientName = budsname;
		this.aClientImageUrl = image_url;

		inflater = (LayoutInflater) activity
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

	}

	public Object getItem(int position) {
		return position;
	}

	public long getItemId(int position) {
		return position;
	}

	public View getView(int position, View convertView, ViewGroup parent) {

		viewHolder = new ViewHolder();

		viewHolder.pos = position;

		// LayoutInflater inflator = activity.getLayoutInflater();
		// convertView = inflator.inflate(R.layout.followerlist_detailed,
		// parent,
		// false);
		// View vi = convertView;
		// if (convertView == null)
		convertView = inflater
				.inflate(R.layout.number_of_client, parent, false);

		viewHolder.member_name = (TextView) convertView
				.findViewById(R.id.clintList_name);
		viewHolder.member_image = (ImageView) convertView
				.findViewById(R.id.id_imageView_pic);
		viewHolder.progressbar = (ProgressBar) convertView
				.findViewById(R.id.progressBar1);
		// viewHolder.member_name.setText(aBudsName.get(position));

		convertView.setTag(viewHolder);
		convertView.setTag(R.id.clintList_name, viewHolder.member_name);
		convertView.setTag(R.id.id_imageView_pic, viewHolder.member_image);

		viewHolder.member_name.setTag(position);
		viewHolder.member_image.setTag(position);

		viewHolder.member_name.setText(aClientName.get(position));
		if (aClientImageUrl.get(position).equals("")) {
			viewHolder.member_image
					.setBackgroundResource(R.drawable.ic_launcher);
		} else {
			// Picasso.with(activity).load(aClientImageUrl.get(position))
			// .into(viewHolder.member_image);
			ApplicationBitmapManager.INSTANCE.loadBitmap(
					aClientImageUrl.get(position), viewHolder.member_image,
					viewHolder.progressbar);
		}

		return convertView;
	}

	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return aClientName.size();
	}

	static class ViewHolder {
		protected ImageView member_image;
		protected TextView member_name;
		protected ProgressBar progressbar;
		int pos;
	}
}
