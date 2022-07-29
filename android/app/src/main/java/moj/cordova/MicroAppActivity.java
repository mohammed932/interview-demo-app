package moj.cordova;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

import androidx.annotation.MainThread;
import androidx.annotation.RequiresApi;


import com.najiz.mobile.R;

import org.apache.cordova.CordovaActivity;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Locale;

import moj.cordova.util.Constant;

public class MicroAppActivity extends CordovaActivity {
    LinearLayout mainView;

//    private LocalBroadcastManager localBroadcastManager;
    private BroadcastReceiver microAppServiceReceiver;
    private BroadcastReceiver logoutActionReceiver;
//    private MicroSharedData microSharedData;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        InitReceiver();

        Bundle extras = getIntent().getExtras();
        if (extras != null && extras.getBoolean("cdvStartInBackground", false)) {
            moveTaskToBack(true);
        }

        InitializeMicroAppService();



        String indexPath = (String) extras.get(Constant.DATA_IN_ACTIVITY);
        if (indexPath != null) {
            OpenMicroApp(Constant.NATIVE_FILE + indexPath);
        }
    }

//    private void InitMicroAppData() {
//        microAppViewModel = MicroAppViewModel.GetInstance();
//    }

    private void InitReceiver() {
//        localBroadcastManager = LocalBroadcastManager.getInstance(this);
        microAppServiceReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                if (intent.getExtras() != null && intent.getExtras().get("MicroAppName") != null) {
                    String microAppName = (String) intent.getExtras().get("MicroAppName");
                    microAppName = microAppName.replace(" ", "");
//                    microSharedData = MicroSharedData.getInstance();

//                    MenusModel.MenuBean microAppMenu = new MenusModel.MenuBean();
//                    microAppMenu.setAppName(microAppName);
//                    microAppMenu.setRoute(microSharedData.route);

//                    openNewMicroActivity(microAppMenu);
                }
            }
        };

        logoutActionReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                signOut();
            }
        };
    }

//    private void openNewMicroActivity(String indexPath) {
//        Intent intent = new Intent(this, MicroAppActivity.class);
//        intent.putExtra(Constant.LOAD_NAV_BAR, true);
//        intent.putExtra(Constant.NAV_SELECTED_ID, -1);
//        intent.putExtra(Constant.MENU_DATA, microAppModelItem);
//        startActivity(intent);
//        overridePendingTransition(R.anim.slide_from_right, R.anim.slide_to_left);
//    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @SuppressLint("ResourceType")
    @Override
    protected void createViews() {
        appView.getView().setId(100);
        appView.getView().setLayoutParams(new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT));

        setContentViewAndWebView(appView.getView());

        if (preferences.contains("BackgroundColor")) {
            try {
                int backgroundColor = preferences.getInteger("BackgroundColor", Color.BLACK);
                appView.getView().setBackgroundColor(backgroundColor);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        appView.getView().requestFocusFromTouch();
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    protected void setContentViewAndWebView(View webview) {
        setContentView(R.layout.micro_app_activity);
        mainView = findViewById(R.id.microAppActivity_FrameLayout);
        mainView.addView(webview);
    }

    private void OpenMicroApp(String menuBeanItem) {
//        CheckMenuRoute(menuBeanItem);
        OpenActivity(menuBeanItem);
    }

    private void OpenActivity(String appUrl) {
        String appConfig = "";

        if (appView != null) {
            appView.handleDestroy();
            appView = null;
        }
        appUrl += "/index.html";
        loadUrl(appUrl);
    }

    @Override
    public Object onMessage(String id, Object data) {
        Log.e("onMessage => " + id,data.toString());

        if ("onReceivedError".equals(id)) {
            JSONObject d = (JSONObject) data;
            try {
                this.onReceivedError(d.getInt("errorCode"), d.getString("description"), d.getString("url"));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        } else if ("exit".equals(id)) {
            finish();
        } else if ("onPageFinished".equals(id) && data.toString().contains("http://localhost/")) {
//            progress.dismiss();
            Log.e("hi","hi");
        }
        return null;
    }

    private void InitializeMicroAppService() {

    }


//    private void CheckMenuRoute(MenusModel.MenuBean menuBeanItem) {
//        if (menuBeanItem.getRoute() != null) {
//            microSharedData = MicroSharedData.getInstance();
//            microSharedData.route = menuBeanItem.getRoute();
//        }
//    }

    @Override
    protected void onResume() {
        super.onResume();
//        localBroadcastManager.registerReceiver(microAppServiceReceiver,
//                new IntentFilter("com.t2.OpenMicroAppService"));
//        localBroadcastManager.registerReceiver(logoutActionReceiver,
//                new IntentFilter("com.t2.Logout"));
    }

    @Override
    protected void onPause() {
        super.onPause();
//        localBroadcastManager.unregisterReceiver(microAppServiceReceiver);
//        localBroadcastManager.unregisterReceiver(logoutActionReceiver);
    }

    @MainThread
    private void signOut() {
//        Intent mainIntent = new Intent(this, LogoutActivity.class);
//        mainIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
//        startActivity(mainIntent);
//        finish();
    }

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(updateBaseContextLocale(base));
    }

    private Context updateBaseContextLocale(Context context) {
        Locale locale = new Locale("ar");
        Locale.setDefault(locale);

        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.N) {
            return updateResourcesLocale(context, locale);
        }

        return updateResourcesLocaleLegacy(context, locale);
    }

    @TargetApi(Build.VERSION_CODES.N_MR1)
    private Context updateResourcesLocale(Context context, Locale locale) {
        Configuration configuration = new Configuration(context.getResources().getConfiguration());
        configuration.setLocale(locale);
        return context.createConfigurationContext(configuration);
    }

    @SuppressWarnings("deprecation")
    private Context updateResourcesLocaleLegacy(Context context, Locale locale) {
        Resources resources = context.getResources();
        Configuration configuration = resources.getConfiguration();
        configuration.locale = locale;
        resources.updateConfiguration(configuration, resources.getDisplayMetrics());
        return context;
    }

    @Override
    public void finish() {
        super.finish();
    }
}
