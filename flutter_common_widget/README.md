
# 封装抽取的常用控件 
    1. 常用弹框： 确认框、提醒框、自定义Content弹框，底部弹框等。
    2. 带阴影的view容器 ShadowContainer， 可设置阴影的扩散大小和颜色
    3. 常用的路由转场动画，从左-->右，右-->左，下--上， 缩放，渐变等。 
    4. 能获取位置和大小可点击的view容器，SizeButton 
    5. 常见的输入框 及 相关的操作方式 
    6. 屏幕适配util
    7. 通知  CustomNotification
    8. 好玩的view， （目前只有球体菜单的粗略实现，后续会补充动画、绘制相关的内容）
    9. 关于使用，可单独运行example工程，查看里边的引用代码。 


# 常用的第三方package :  
### 1. 网络请求 dio是一个强大的Dart Http请求库，支持Restful API、FormData、拦截器、请求取消、Cookie管理、文件上传/下载、超时、自定义适配器等...
> 地址： https://github.com/flutterchina/dio/blob/master/README-ZH.md
```
dependencies:
  dio: ^2.1.x  // 请使用pub上2.1分支的最新版本

```

### 2. common_utils (Dart常用工具类库) ,包含日期，正则，倒计时，定时任务，时间轴等工具类,如果您是Flutter项目，请使用Flutter工具类库 flustars，该库依赖于本项目。
flustars库为大家提供更多的常用工具类， 例如SpUtil，ScreenUtil, DirectoryUtil等等
> 地址： https://pub.flutter-io.cn/packages/common_utils#-readme-tab-
```
dependencies:
  flustars: ^0.2.6+1  
```
    Dart常用工具类库 common_utils
    1、TimelineUtil : 时间轴.
    2、TimerUtil : 倒计时，定时任务.
    3、MoneyUtil : 精确转换，元转分，分转元，支持格式输出.
    4、LogUtil : 简单封装打印日志. 5、DateUtil : 日期转换格式化输出.
    6、RegexUtil : 正则验证手机号，身份证，邮箱等等.
    7、NumUtil : 保留x位小数, 精确加、减、乘、除, 防止精度丢失.
    8、ObjectUtil : 判断对象是否为空(String List Map),判断两个List是否相等.
    9、EnDecodeUtil : md5加密，Base64加/解密.
    10、TextUtil : 银行卡号每隔4位加空格，每隔3三位加逗号，隐藏手机号等等.
    
    Flutter工具类库 flustars
    1、SpUtil : 单例"同步"SharedPreferences工具类。支持get传入默认值，支持存储对象，支持存储对象数组。
    2、ScreenUtil : 屏幕适配，获取屏幕宽、高、密度，AppBar高，状态栏高度，屏幕方向.
    3、WidgetUtil : 监听Widget渲染状态，获取Widget宽高，在屏幕上的坐标，获取网络/本地图片尺寸.
    4、DirectoryUtil : 文件目录工具类.
    5、DioUtil : 单例Dio网络工具类(已迁移至此处DioUtil)。
    
### 3. flutter_screenutil 屏幕适配方案，让你的UI在不同尺寸的屏幕上都能显示合理的布局!
> 地址： https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_CN.md
```
dependencies:
  flutter_screenutil: ^0.5.3
```

