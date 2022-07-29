package com.cyph.cordova;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.net.Uri;
import android.util.Base64;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.json.JSONObject;

public class FileReaderThread extends Thread {
    private Intent data;
    private int requestCode;
    private int resultCode;
    private CordovaInterface cordova;
    private CallbackContext callback;

    public FileReaderThread(Intent data, int requestCode, int resultCode, CordovaInterface cordova, CallbackContext callback) {
        this.data = data;
        this.requestCode = requestCode;
        this.resultCode = resultCode;
        this.cordova = cordova;
        this.callback = callback;
    }

    public void run() {
        try {
            if (requestCode == Chooser.PICK_FILE_REQUEST && this.callback != null) {
                if (resultCode == Activity.RESULT_OK) {
                    Uri uri = data.getData();

                    if (uri != null) {
                        ContentResolver contentResolver =
                                this.cordova.getActivity().getContentResolver();

                        String name = Chooser.getDisplayName(contentResolver, uri);

                        String mediaType = contentResolver.getType(uri);
                        if (mediaType == null || mediaType.isEmpty()) {
                            mediaType = "application/octet-stream";
                        }

                        byte[] bytes = Chooser.getBytesFromInputStream(
                                contentResolver.openInputStream(uri)
                        );

                        String base64 = Base64.encodeToString(bytes, Base64.DEFAULT);

                        JSONObject result = new JSONObject();

                        result.put("data", base64);
                        result.put("mediaType", mediaType);
                        result.put("name", name);
                        result.put("uri", uri.toString());

                        this.callback.success(result.toString());
                    } else {
                        this.callback.error("File URI was null.");
                    }
                } else if (resultCode == Activity.RESULT_CANCELED) {
                    this.callback.success("RESULT_CANCELED");
                } else {
                    this.callback.error(resultCode);
                }
            }
        } catch (Exception err) {
            this.callback.error("Failed to read file: " + err.toString());
        }
    }
}