package com.neusoft.flutter_umengshare;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;

import android.os.Build;
import android.util.Log;
import com.umeng.commonsdk.UMConfigure;
//import com.umeng.message.IUmengRegisterCallback;
//import com.umeng.message.PushAgent;
import com.umeng.facebook.FacebookSdk;
import com.umeng.socialize.PlatformConfig;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.UMAuthListener;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.media.UMMin;
import com.umeng.socialize.media.UMVideo;
import com.umeng.socialize.media.UMWeb;
import com.umeng.socialize.media.UMusic;
//import com.umeng.socialize.weixin.view.WXCallbackActivity;
//import com.umeng.socialize.weixin.view.WXCallbackActivityQQ;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.umeng.socialize.shareboard.ShareBoardConfig;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;
import io.flutter.plugin.common.PluginRegistry.NewIntentListener;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener;

//import static anetwork.channel.download.DownloadManager.TAG;

import org.json.JSONArray;
import org.json.JSONObject;

import static com.umeng.facebook.FacebookSdk.getApplicationContext;


/**
 * FlutterUmengsharePlugin
 */
public class FlutterUmengsharePlugin implements MethodCallHandler, ActivityResultListener, RequestPermissionsResultListener {

  private final Registrar registrar;
  private final MethodChannel channel;

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_umengshare");
    channel.setMethodCallHandler(new FlutterUmengsharePlugin(registrar, channel));
  }

  private FlutterUmengsharePlugin(Registrar registrar, MethodChannel channel) {
    this.registrar = registrar;
    this.channel = channel;
//    init(registrar.context());
  }

  private void init(Context context, String appkey) {
    UMConfigure.setLogEnabled(true);
    UMConfigure.init(context, appkey, "umengshare", UMConfigure.DEVICE_TYPE_PHONE, "");//58edcfeb310c93091c000be2 5965ee00734be40b580001a0

//    //获取消息推送代理示例
//    PushAgent mPushAgent = PushAgent.getInstance(context);
//
//    //注册推送服务，每次调用register方法都会回调该接口
//    mPushAgent.register(new IUmengRegisterCallback() {
//      @Override
//      public void onSuccess(String deviceToken) {
//        //注册成功会返回deviceToken deviceToken是推送消息的唯一标志
//        Log.i(TAG,"注册成功：deviceToken：-------->  " + deviceToken);
//      }
//      @Override
//      public void onFailure(String s, String s1) {
//        Log.e(TAG,"注册失败：-------->  " + "s:" + s + ",s1:" + s1);
//      }
//    });
//    PushAgent.getInstance(context).onAppStart();
  }


  private void setupUSharePlatforms(Context context, List<Map> platforms) {

    for (Map object : platforms) {
      String platform = object.get("platform").toString();
      String appKey = object.get("appKey").toString();
      String appSecret = object.get("appSecret").toString();
      String redirectURL = object.get("redirectURL").toString();

      SHARE_MEDIA share_media = getPlatForm(Integer.parseInt(platform));

      if (share_media == SHARE_MEDIA.WEIXIN) {
        PlatformConfig.setWeixin(appKey, appSecret);
      } else if (share_media == SHARE_MEDIA.SINA) {
        PlatformConfig.setSinaWeibo(appKey, appSecret, redirectURL);
      } else if (share_media == SHARE_MEDIA.QQ) {
        PlatformConfig.setQQZone(appKey, appSecret);
      } else if (share_media == SHARE_MEDIA.TWITTER) {
        PlatformConfig.setTwitter(appKey, appSecret);
      }  else if (share_media == SHARE_MEDIA.FACEBOOK) {
        FacebookSdk.sdkInitialize(getApplicationContext());
      } else if (platform.equals("")) {

      } else {

      }
    }
  }

  @TargetApi(Build.VERSION_CODES.KITKAT)
  @Override
  public void onMethodCall(MethodCall call, Result result) {

    if (call.method.equals("initUmengAppKey")) {
      String appkey = call.argument("appKey");
      init(this.registrar.context(), appkey);

    } else if (call.method.equals("setupUSharePlatforms")) {

      List<Map> sharePlatforms = call.argument("sharePlatforms");

      setupUSharePlatforms(this.registrar.context(), sharePlatforms);

    } else if (call.method.equals("shareText")) {
      int platform = call.argument("platform");
      String text = call.argument("text");
      shareText(sharePlatForm(platform), text, result);
    } else if (call.method.equals("shareImage")) {
      int platform = call.argument("platform");
      String thumb = call.argument("thumb");
      String image = call.argument("image");
      shareImage(sharePlatForm(platform), thumb, image, result);
    } else if (call.method.equals("shareMedia")) {
      int platform = call.argument("platform");
      int type = call.argument("type");
      String title = call.argument("title");
      String desc = call.argument("desc");
      String thumb = call.argument("thumb");
      String link = call.argument("link");
      shareMedia(sharePlatForm(platform), type, title, desc, thumb, link, result);
    } else if (call.method.equals("login")) {
      int platform = call.argument("platform");
      login(getPlatForm(platform), result);
    } else if (call.method.equals("shareMiniApp")) {
      String username = call.argument("username");
      String title = call.argument("title");
      String desc = call.argument("desc");
      String thumb = call.argument("thumb");
      String url = call.argument("url");
      String path = call.argument("path");
      shareMiniApp(username, title, desc, thumb, url, path, result);
    } else if (call.method.equals("checkInstall")) {
      int platform = call.argument("platform");
      boolean flag = UMShareAPI.get(registrar.context()).isInstall(registrar.activity(), getPlatForm(platform));
      result.success(flag);
    } else if (call.method.equals("shareUI")) {
      String title = call.argument("title");
      String desc = call.argument("desc");
      String thumb = call.argument("thumb");
      String link = call.argument("link");
      List sharePlatforms = call.argument("sharePlatforms");
      shareUI(title, desc, thumb, link, sharePlatforms, result);
    } else if (call.method.equals("getPlatformVersion")) {
        result.success("0.1.6");
    } else {
      result.notImplemented();
    }
  }

  private SHARE_MEDIA sharePlatForm(int platform) {
    final SHARE_MEDIA result;
    switch (platform) {
      case 0:
        result = SHARE_MEDIA.SINA;
        break;
      case 1:
        result = SHARE_MEDIA.WEIXIN;
        break;
      case 2:
        result = SHARE_MEDIA.WEIXIN_CIRCLE;
        break;
      case 3:
        result = SHARE_MEDIA.WEIXIN_FAVORITE;
        break;
      case 4:
        result = SHARE_MEDIA.QQ;
        break;
      case 5:
        result = SHARE_MEDIA.QZONE;
        break;
      case 6:
        result = SHARE_MEDIA.FACEBOOK;
        break;
      case 7:
        result = SHARE_MEDIA.TWITTER;
        break;
      default:
        result = SHARE_MEDIA.SINA;
        break;

    }
    return result;
  }

  private SHARE_MEDIA getPlatForm(int platform) {
    final SHARE_MEDIA result;
    switch (platform) {
      case 0:
        result = SHARE_MEDIA.SINA;
        break;
      case 1:
        result = SHARE_MEDIA.WEIXIN;
        break;
      case 2:
        result = SHARE_MEDIA.QQ;
        break;
      case 3:
        result = SHARE_MEDIA.FACEBOOK;
        break;
      case 4:
        result = SHARE_MEDIA.TWITTER;
        break;
      default:
        result = SHARE_MEDIA.SINA;
        break;

    }
    return result;
  }

  private void shareUI(String title, String desc, String thumb, String link, List sharePlatforms, Result result) {

    UMImage thumbImage = new UMImage(registrar.activity(), thumb);
    UMWeb web = new UMWeb(link);
    web.setTitle(title);//标题
    web.setThumb(thumbImage);  //缩略图
    web.setDescription(desc);//描述

    SHARE_MEDIA[] displaylist = new SHARE_MEDIA[sharePlatforms.size()];

    UMShareAPI umShareAPI = UMShareAPI.get(registrar.activity());

    List<SHARE_MEDIA> tempDisplaylist = new ArrayList();

    if (sharePlatforms != null) {
      for (int i = 0; i < sharePlatforms.size(); i++) {
        int type = (int) sharePlatforms.get(i);

//        if (umShareAPI.isInstall(registrar.activity(),sharePlatForm(type))) {
          tempDisplaylist.add(sharePlatForm(type));
//        }
      }

      for (int j = 0; j < tempDisplaylist.size(); j++){
        displaylist[j] = tempDisplaylist.get(j);
      }
    }

    ShareBoardConfig shareBoardConfig = new ShareBoardConfig();
    shareBoardConfig.setTitleText("分享到");
    shareBoardConfig.setIndicatorVisibility(false);


    new ShareAction(registrar.activity()).withMedia(web).setDisplayList(displaylist)
            .setCallback(new UmengshareActionListener(registrar.activity(), result)).open(shareBoardConfig);
  }

  private void shareText(SHARE_MEDIA platform, String text, final Result result) {
    new ShareAction(registrar.activity()).setPlatform(platform)
            .withText(text)
            .setCallback(new UmengshareActionListener(registrar.activity(), result)).share();
  }

  private void shareImage(SHARE_MEDIA platform, String thumb, String image, final Result result) {

    final Activity activity = registrar.activity();
    UMImage thumbImage = new UMImage(activity, thumb);
    UMImage sImage = new UMImage(activity, image);
    sImage.setThumb(thumbImage);
    new ShareAction(activity)
            .setPlatform(platform)
            .withMedia(sImage)
            .setCallback(new UmengshareActionListener(activity, result)).share();
  }

  private void shareMedia(SHARE_MEDIA platform, int sharetype, String title, String desc, String thumb, String link, final Result result) {

    Activity activity = registrar.activity();
    if (sharetype == 0) {
      UMImage thumbImage = new UMImage(activity, thumb);
      UMusic music = new UMusic(link);
      music.setTitle(title);//标题
      music.setThumb(thumbImage);  //缩略图
      music.setDescription(desc);//描述
      new ShareAction(activity).setPlatform(platform)
              .withMedia(music)
              .setCallback(new UmengshareActionListener(activity, result)).share();
    } else if (sharetype == 1) {
      UMImage thumbImage = new UMImage(activity, thumb);
      UMVideo video = new UMVideo(link);
      video.setTitle(title);//标题
      video.setThumb(thumbImage);  //缩略图
      video.setDescription(desc);//描述
      new ShareAction(activity).setPlatform(platform)
              .withMedia(video)
              .setCallback(new UmengshareActionListener(activity, result)).share();
    } else if (sharetype == 2) {
      UMImage thumbImage = new UMImage(activity, thumb);
      UMWeb web = new UMWeb(link);
      web.setTitle(title);//标题
      web.setThumb(thumbImage);  //缩略图
      web.setDescription(desc);//描述

      new ShareAction(activity).setPlatform(platform)
              .withMedia(web)
              .setCallback(new UmengshareActionListener(activity, result)).share();
    } else {
      Map<String, Object> map = new HashMap<>();
      map.put("um_status", "ERROR");
      map.put("um_msg", "INVALID TYPE");
      result.success(map);
    }

  }

  private void shareMiniApp(String username, String title, String desc, String thumb, String url, String path, final Result result) {
    UMMin umMin = new UMMin(url);
    umMin.setThumb(new UMImage(registrar.activity(), thumb));
    umMin.setTitle(title);
    umMin.setDescription(desc);
    umMin.setPath(path);
    umMin.setUserName(username);
    new ShareAction(registrar.activity())
            .withMedia(umMin)
            .setPlatform(SHARE_MEDIA.WEIXIN)
            .setCallback(new UmengshareActionListener(registrar.activity(), result)).share();
  }


  private void login(SHARE_MEDIA platform, final Result result) {

    UMShareAPI.get(registrar.activity()).getPlatformInfo(registrar.activity(), platform, new UMAuthListener() {
      @Override
      public void onStart(SHARE_MEDIA share_media) {

      }

      @Override
      public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> map) {
        map.put("um_status", "SUCCESS");
        result.success(map);

      }

      @Override
      public void onError(SHARE_MEDIA share_media, int i, Throwable throwable) {
        Map<String, Object> map = new HashMap<>();
        map.put("um_status", "ERROR");
        map.put("um_msg", throwable.getMessage());
        result.success(map);
      }

      @Override
      public void onCancel(SHARE_MEDIA share_media, int i) {
        Map<String, Object> map = new HashMap<>();
        map.put("um_status", "CANCEL");
        result.success(map);
      }
    });
  }

  @Override
  public boolean onActivityResult(int i, int i1, Intent intent) {
    UMShareAPI.get(registrar.activity()).onActivityResult(i, i1, intent);
    return false;
  }

  @Override
  public boolean onRequestPermissionsResult(int i, String[] strings, int[] ints) {
    return false;
  }
}
