package daangnmungcat.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

public class GpsToAddressService {
	double latitude;
	double longitude;
	String regionAddress;

	public GpsToAddressService(double latitude, double longitude) throws Exception {
		this.latitude = latitude;
		this.longitude = longitude;
		this.regionAddress = getRegionAddress(getJSONData(getApiAddress()));
	}

	private String getApiAddress() {
		//https://maps.googleapis.com/maps/api/geocode/json?latlng=37.566535,126.977969&language=ko&key=AIzaSyCI3czUjEtTIOLyljHyhEUo6ZVhAiel4Is
		//String apiURL = "http://maps.googleapis.com/maps/api/geocode/json?latlng=" + latitude + "," + longitude + "&language=ko";
		String apiURL = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + latitude + "," + longitude + "&language=ko&key=AIzaSyBydfS3SpBFCvXonhHL9Z-FYm7wzDMTeoQ";
		return apiURL;
	}

	public String getJSONData(String apiURL) throws Exception {
		String jsonString = new String();
		String buf;
		URL url = new URL(apiURL);
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		while ((buf = br.readLine()) != null) {
			jsonString += buf;
		}
		return jsonString;
	}

	private String getRegionAddress(String jsonString) {
		JSONObject jObj = (JSONObject) JSONValue.parse(jsonString);
		JSONArray jArray = (JSONArray) jObj.get("results");
		jObj = (JSONObject) jArray.get(0);
		return (String) jObj.get("formatted_address");
	}

	public String getAddress() {
		return regionAddress;
	}

	@Override
	public String toString() {
		return String.format("GpsToAddressService [latitude=%s, longitude=%s, regionAddress=%s]", latitude, longitude,
				regionAddress);
	}
}
