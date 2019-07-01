# custom_plugin


# flutter 调用Android原生方法并传值 
flutter代码：
```

void showAndroidToast(String msg) {
  MethodChannel methodChannel = MethodChannel(channel);

  // 调用原生的showToast方法，并传递复杂类型参数
  methodChannel.invokeMethod<bool>("showToast",
    {
      "values": ["aaa", "bbb","ccc"],
    }
  ).then((value) {
    cPrint("$value");
  });
}
```
Android代码： 
```
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
        } else {
            result.notImplemented();
        }
    }
}


```