package com.t2.SharedPreferences;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

public class T2SharedPreferences extends CordovaPlugin {
    private NSharedPreferences nSharedPreferences;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        nSharedPreferences = NSharedPreferences.getInstance(cordova.getActivity());
        if (action.equals("coolMethod")) {
            String message = args.getString(0);
            this.coolMethod(message, callbackContext);
            return true;
        } else if (action.equals("put")) {
            String key = args.getString(0);
            String value = args.getString(1);
            this.put(key, value, callbackContext);
            return true;
        } else if (action.equals("getString")) {
            String key = args.getString(0);
            this.getString(key, callbackContext);
            return true;
        } else if (action.equals("getToken")) {
            this.getToken(callbackContext);
            return true;
        } else if (action.equals("getServerURL")) {
            this.getServerURL(callbackContext);
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

    private void put(String key, Object value, CallbackContext callbackContext) {
        if (key != null && key.length() > 0) {
            nSharedPreferences.putValue(key, value);
            callbackContext.success();
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }

    private void getString(String key, CallbackContext callbackContext) {
        if (key != null && key.length() > 0) {
            callbackContext.success(nSharedPreferences.getString(key, null));
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }

    private void getToken(CallbackContext callbackContext) {
        callbackContext.success(nSharedPreferences.getString("Token", null));
    }

    private void getServerURL(CallbackContext callbackContext) {
        callbackContext.success(nSharedPreferences.getString("ServerURL", null));
    }

}
