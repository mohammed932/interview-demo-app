package com.t2.SharedPreferences;

import android.content.Context;
import android.content.SharedPreferences;


import java.util.Set;

import moj.cordova.util.Constant;

public class NSharedPreferences {
    private static final String PREF_NAME = "N_PREFERENCE";
    private SharedPreferences sharedPreferences;
    private SharedPreferences.Editor editor;
    private final static Object objectSync = new Object();
    private static NSharedPreferences ourInstance = null;

    public static NSharedPreferences getInstance(Context context) {
        if (ourInstance == null)
            ourInstance = new NSharedPreferences(context);

        return ourInstance;
    }

    public void clearToken() {
        sharedPreferences.edit().remove("Token").commit();
    }

    public void clearImpersonationContext() {
        sharedPreferences.edit().remove(Constant.ImpersonationContext).commit();
    }

    private NSharedPreferences(Context context) {
        if (context == null)
            throw new IllegalArgumentException("Context can't be null");
        sharedPreferences = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        editor = sharedPreferences.edit();
    }

    public void putValue(String key, Object object) {
        synchronized (objectSync) {
            if (object instanceof Boolean) {
                editor.putBoolean(key, (Boolean) object).apply();
                return;
            }
            if (object instanceof Integer) {
                editor.putInt(key, (Integer) object).apply();
                return;
            }

            if (object instanceof String) {
                editor.putString(key, (String) object).apply();
                return;
            }
            if (object instanceof Float) {
                editor.putFloat(key, (Float) object).apply();
                return;
            }
            if (object instanceof Long) {
                editor.putLong(key, (Long) object).apply();
                return;
            }
            if (object instanceof Set)
                try {
                    editor.putStringSet(key, (Set<String>) object).apply();
                } catch (ClassCastException e) {
                    e.printStackTrace();
                }
        }
    }

    public Set<String> getSet(String key) {
        return sharedPreferences.getStringSet(key, null);
    }

    public Set<String> getSet(String key, Set<String> defaultValue) {
        return sharedPreferences.getStringSet(key, defaultValue);
    }


    public long getLong(String key) {
        return sharedPreferences.getLong(key, 0L);
    }

    public long getLong(String key, long defaultValue) {
        return sharedPreferences.getLong(key, defaultValue);
    }

    public float getFloat(String key) {
        return sharedPreferences.getFloat(key, 0f);
    }

    public float getFloat(String key, float defaultValue) {
        return sharedPreferences.getFloat(key, defaultValue);
    }

    public String getString(String key) {
        return sharedPreferences.getString(key, "");
    }

    public String getString(String key, String defaultValue) {
        return sharedPreferences.getString(key, defaultValue);
    }

    public int getInt(String key) {
        return sharedPreferences.getInt(key, 0);
    }


    public int getInt(String key, int defaultValue) {
        return sharedPreferences.getInt(key, defaultValue);
    }


    public boolean getBoolean(String key) {
        return sharedPreferences.getBoolean(key, false);
    }


    public boolean getBoolean(String key, boolean defaultValue) {
        return sharedPreferences.getBoolean(key, defaultValue);
    }
}
