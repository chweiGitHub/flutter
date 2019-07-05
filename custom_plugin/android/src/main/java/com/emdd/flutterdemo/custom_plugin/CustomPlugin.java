package com.emdd.flutterdemo.custom_plugin;

import android.app.Activity;
import android.util.Log;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * CustomPlugin
 */
public class CustomPlugin implements MethodCallHandler {

    private CustomPlugin(Activity activity) {
        this.mActivity = activity;
    }

    private Activity mActivity;

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "custom_plugin");
        channel.setMethodCallHandler(new CustomPlugin(registrar.activity()));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("showToast")) {
            Log.i("----->", call.argument("values").toString());
            ArrayList arr = call.argument("values");
            for (int i = 0; i < arr.size(); i++) {
                Log.i("---->", "value:" + arr.get(i));
            }
            Toast.makeText(mActivity, "test--" + call.argument("values").toString(), Toast.LENGTH_LONG).show();
            result.success(true);
        } else if (call.method.equals("stringTest")) {


            String x = new String("goeasyway");
            change(x);
            Log.i("---->", x);
            result.success (true);

        } else {
            result.notImplemented();
        }
    }

    public void change(String x) {
        Log.i("----啊啊啊a>", x);
        x = x+"--test11";
    }

}
