package com.t2.microAppService;

import android.content.Intent;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import androidx.localbroadcastmanager.content.LocalBroadcastManager;

public class MicroAppService extends CordovaPlugin implements MicroSharedData.ReCall {

    private LocalBroadcastManager localBroadcastManager;
    private MicroSharedData microSharedData;
    private CallbackContext callbackContext;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (localBroadcastManager == null)
            localBroadcastManager = LocalBroadcastManager.getInstance(cordova.getActivity());
        if (action.equals("coolMethod")) {
            String message = args.getString(0);
            this.coolMethod(message, callbackContext);
            return true;
        } else if (action.equals("openOtherMicroApp")) {
            String microAppName = args.getString(0);
            String route = args.getString(1);
            String data = args.getString(2);
            this.openOtherMicroApp(microAppName, route, data, callbackContext);
            return true;
        } else if (action.equals("CheckFromOtherMicroApp")) {
            CheckFromOtherMicroApp(callbackContext);
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

    private void openOtherMicroApp(String microAppName, String route, String data, CallbackContext callbackContext) {
        if (microAppName != null && !microAppName.equals("")) {
            microSharedData = MicroSharedData.getInstance();
            microSharedData.microAppData = data;
            microSharedData.route = route;
            Intent intent = new Intent("com.t2.OpenMicroAppService");
            intent.putExtra("MicroAppName", microAppName);
            this.localBroadcastManager.sendBroadcast(intent);
            callbackContext.success();
        } else {
            callbackContext.error("Micro App Name not found");
        }

    }

    private void CheckFromOtherMicroApp(CallbackContext callbackContext) {
        this.callbackContext = callbackContext;
        microSharedData = MicroSharedData.getInstance();
        microSharedData.setReCall(this);
        SendCallbackData();
    }

    private void SendCallbackData(){
        if (microSharedData.route == null) {
            callbackContext.error("Route Not Found");
        } else {
            JSONObject jsonData = new JSONObject();
            try {
                if (microSharedData.microAppData != null)
                    jsonData.put("Data", microSharedData.microAppData);
                jsonData.put("Route", microSharedData.route);
            } catch (JSONException e) {
                e.printStackTrace();
            }

            PluginResult result = new PluginResult(PluginResult.Status.OK, jsonData);
            result.setKeepCallback(true);
            callbackContext.sendPluginResult(result);
            microSharedData.microAppData = null;
            microSharedData.route = null;
        }
    }

    private void ReCallCheck() {
        if (callbackContext != null)
            SendCallbackData();
    }

    @Override
    public void CheckFromOtherMicroApp() {
        ReCallCheck();
    }
}
