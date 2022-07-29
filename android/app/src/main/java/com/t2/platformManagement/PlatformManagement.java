package com.t2.platformManagement;

import android.content.Intent;
import android.util.Log;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Iterator;

import moj.cordova.util.Constant;

/**
 * This class echoes a string called from JavaScript.
 */
public class PlatformManagement extends CordovaPlugin {
    private LocalBroadcastManager localBroadcastManager;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (localBroadcastManager == null)
            localBroadcastManager = LocalBroadcastManager.getInstance(cordova.getActivity());
        if (action.equals("coolMethod")) {
            String message = args.getString(0);
            this.coolMethod(message, callbackContext);
            return true;
        } else if (action.equals("exitApp")) {
            this.exitApp(callbackContext);
            return true;
        } else if (action.equals("logout")) {
            this.logout(callbackContext);
            return true;
        } else if (action.equals("showNavigation")) {
            this.showNavigation(callbackContext);
            return true;
        } else if (action.equals("hideNavigation")) {
            this.hideNavigation(callbackContext);
            return true;
        } else if (action.equals("trackEvent")) {
            this.trackEvent(args, callbackContext);
            return true;
        }
        return false;
    }

    private void coolMethod(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }

    private void exitApp(CallbackContext callbackContext) {
        callbackContext.success();
        cordova.getActivity().finish();
    }

    private void logout(CallbackContext callbackContext) {
        Intent intent = new Intent("com.t2.Logout");
        this.localBroadcastManager.sendBroadcast(intent);
        callbackContext.success();
    }

    private void showNavigation(CallbackContext callbackContext) {
        Intent intent = new Intent(Constant.IsShowNavigationView);
        intent.putExtra(Constant.IsShowNavigationView, true);
        this.localBroadcastManager.sendBroadcast(intent);
        callbackContext.success();
    }

    private void hideNavigation(CallbackContext callbackContext) {
        Intent intent = new Intent(Constant.IsShowNavigationView);
        intent.putExtra(Constant.IsShowNavigationView, false);
        this.localBroadcastManager.sendBroadcast(intent);
        callbackContext.success();
    }

    private void trackEvent(JSONArray args, CallbackContext callbackContext) {
        try {
            HashMap<String, String> properties = new HashMap<>();

            String event = (String) ((JSONObject) args.get(0)).get("name");
            JSONObject jsonObject = (JSONObject) args.get(1);
            Iterator<String> iter = jsonObject.keys();
            while (iter.hasNext()) {
                String key = iter.next();
                if (key.equals("userId"))
                    properties.put(key, md5(jsonObject.getString(key)));
                else
                    properties.put(key, jsonObject.getString(key));
            }

//            Analytics.trackEvent(event, properties);
        } catch (Exception e) {
            Log.e("trackEvent.cordova", e.getStackTrace().toString());
        }
        callbackContext.success();
    }

    private String md5(final String s) {
        final String MD5 = "MD5";
        try {
            MessageDigest digest = java.security.MessageDigest
                    .getInstance(MD5);
            digest.update(s.getBytes());
            byte messageDigest[] = digest.digest();
            StringBuilder hexString = new StringBuilder();
            for (byte aMessageDigest : messageDigest) {
                String h = Integer.toHexString(0xFF & aMessageDigest);
                while (h.length() < 2)
                    h = "0" + h;
                hexString.append(h);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "";
    }
}
