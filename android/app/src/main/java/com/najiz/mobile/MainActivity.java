package com.najiz.mobile;

import android.content.Intent;
import android.util.Log;
import androidx.annotation.NonNull;
import com.t2.SharedPreferences.NSharedPreferences;
import com.t2.microAppService.MicroSharedData;
import java.util.HashMap;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import moj.cordova.MicroAppActivity;
import moj.cordova.util.Constant;

public class MainActivity extends FlutterActivity {
    

    public static final String ServerURL = "ServerURL";
    public static String ApplicationInsightsKey = "InstrumentationKey";
    public static String SiteKey = "SiteKey";
    public static String SSO_Url = "SSO_Url";
    public static String ClientId = "ClientId";
    public static String ClientSecret = "ClientSecret";
    public static String LOAD_NAV_BAR = "LOAD_NAV_BAR";
    public static String MENU_DATA = "MenuData";


    private static final String CHANNEL = "com.najiz_flutter.main/downloadMicroApp";
    private static final String CONFIG_CHANNEL = "com.najiz_flutter.main/configurations";

    
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

        NSharedPreferences nSharedPreferences = NSharedPreferences.getInstance(this);
        
        super.configureFlutterEngine(flutterEngine);
        
        // Download Micro App CHANNEL
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            HashMap args = (HashMap) call.arguments;
                            String route = (String) args.get("route");
                            String appName = (String) args.get("appName");
                            String token = (String) args.get("token");


                            MicroSharedData microSharedData = MicroSharedData.getInstance();

                            if (call.method.equals("openWebView")) {
                                Intent intent = new Intent(this, MicroAppActivity.class);
                                intent.putExtra(Constant.DATA_IN_ACTIVITY, (String) args.get("path"));

                                if (route != null && !route.isEmpty()) {
                                    Log.e("Route name", "Set Route > " + route);
                                    microSharedData.route = route;
                                }

                                if (token != null && !token.isEmpty()) {
                                    nSharedPreferences.putValue("Token", token);
                                } else {
                                    nSharedPreferences.clearToken();
                                }

                                startActivity(intent);
                                result.success("Android Test Message: " + call.arguments + " -_____- " + appName);
                            } else {
                                result.notImplemented();
                            }

                        }
                );

        // Save Configuration CHANNEL
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CONFIG_CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            HashMap args = (HashMap) call.arguments;
                            if (call.method.equals("saveConfig")) {
                                HashMap config = (HashMap) args.get("config");
                                nSharedPreferences.putValue(ServerURL, ((String) config.get("baseUrl")));
                                nSharedPreferences.putValue("baseUrl", ((String) config.get("baseUrl")));
                                nSharedPreferences.putValue(ApplicationInsightsKey, ((String)config.get("ApplicationInsightsKey")));
                                nSharedPreferences.putValue(SSO_Url, ((String)config.get("SSOUrl")));
                                nSharedPreferences.putValue(ClientId, ((String)config.get("ClientId")));
                                nSharedPreferences.putValue(ClientSecret, ((String)config.get("Secret")));
                                nSharedPreferences.putValue(SiteKey, ((String)config.get("SiteKey")));
                                
                                result.success("Save this configuration in Native: " + nSharedPreferences.getString(ServerURL));
                            } else {
                                result.notImplemented();
                            }

                        }
                );
    }
}


