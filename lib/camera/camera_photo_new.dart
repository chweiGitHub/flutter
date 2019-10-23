import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:common/common.dart';

void main() {

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft])
      .then((_) {
//    runApp(new MyApp());
    InnerWidgetsFlutterBinding.ensureInitialized(screenWidth.toInt())
      ..attachRootWidget(new StartPage())
      ..scheduleWarmUpFrame();
  });runApp(StartPage());
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TakePicturePage(),
    );
  }
}

class TakePicturePage extends StatefulWidget {
  @override
  _TakePicturePageState createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage>
    with WidgetsBindingObserver {
  List<CameraDescription> cameras;
  CameraController controller;

  bool canPreview = false;

  /// 当前拍摄的照片路径
  /// 如果有值就显示预览图片
  /// 如果没有值就限制拍摄界面
  String currentImagePath;

//  double aspectRatio;

  @override
  void initState() {
    print("init state");
    _initCamera().then((cameras) {
      if (cameras != null) {
        print("相机的个数为： ${cameras.length}");
        Timer(Duration(seconds: 0), () {
          onNewCameraSelected(cameras.first);
        });
      }
    });
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  Future _initCamera() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch (e) {
      print('Error: ${e.code}\nError Message: ${e.description}');
    }
    return cameras;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(
        "didChangeAppLifecycleState--------------------------------------------> ${state.toString()}");
    print(controller == null);

    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      //if (controller != null) {
      onNewCameraSelected(controller?.description);
      //}
    }
  }

  @override
  Widget build(BuildContext context) {
    var borderWidth = 30.0;
    var borderBgColor = Colors.black26;

    if(controller?.value?.previewSize!= null??false) {
      print("宽高比： ${controller?.value?.aspectRatio ?? "---"}");
    }

    Widget previewWidget;
    if (haveImage()) {
      Image file = Image.file(
        File(currentImagePath ?? ""),
        fit: BoxFit.fitWidth,
      );

      //print("图片的宽高：  width: ${file.width}, height: ${file.height}");

      previewWidget = Container(
        width: double.infinity,
        child: file,
      );
    } else {
      previewWidget = _previewWidget();
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.black,
                      alignment: haveImage() ? Alignment.center : null,
                      child: previewWidget,
                      width: double.infinity,
                    ),
                    Offstage(
                      offstage: haveImage(),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: borderWidth,
                            color: borderBgColor,
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: borderWidth,
                                  color: borderBgColor,
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                                Container(
                                  width: borderWidth,
                                  color: borderBgColor,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: borderWidth,
                            color: borderBgColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 500.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _selectPicture();
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            color: Colors.deepOrange,
                            child: Text("相册"),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _selectPictureFromCamera();
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            color: Colors.deepOrange,
                            child: Text(haveImage() ? "重拍" : "拍照"),
                          ),
                        ),
                      ),
                    ),
                  Expanded(child: Container (
                    color: Colors.deepOrange,
                    child: Image.file(File(currentImagePath ?? "")),
                  )),
//
//                    Container(
//                      color: Colors.deepOrange,
//                      child: SizedBox(
//                        child: Image.file(File(currentImagePath ?? "")),
//                        width: 164.0,
//                        height: 164.0,
//                      ),
//                      width: 164.0,
//                      height: 164.0,
//                    ),
//                    OrientationBuilder(
//                      builder: (context, orientation) {
//                        print("orientation...");
//                        return Container(
//                          child: Text(orientation == Orientation.portrait
//                              ? "aaa"
//                              : "bbb"),
//                        );
//                      },
//                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool haveImage() {
    return currentImagePath != null && currentImagePath.length > 0;
  }

  Widget _previewWidget() {

    print("_previewWidget--time：${DateTime.now().millisecondsSinceEpoch}--controller == null:${controller == null } ");
    if (controller != null){
      print("controller.value.isInitialized:${controller.value.isInitialized}");
    }
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else if (canPreview) {
      return AspectRatio(
        aspectRatio: controller?.value?.aspectRatio ?? 1,
        child: Container(
          width: 300,
          height: 160,
          child: CameraPreview(controller),
        ),
      );
    } else {
      return Container();
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    print(
        "onNewCameraSelected-----cameraDescription==null? ${cameraDescription == null}");
    if (cameraDescription == null) {
      print("是空的");
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.veryHigh,
      enableAudio: true,
    );
//    controller.value = controller.value.copyWith(previewSize: Size(1600, 3000));

//    setState(() {
//      aspectRatio = controller.value.aspectRatio;
//    });

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        //showInSnackBar('Camera error ${controller.value.errorDescription}');
        print("Camera error ${controller.value.errorDescription}");
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print("error : ${e.code} --- ${e.description}");
    }
    canPreview = true;
    if (mounted) {
      setState(() {});
    }
  }
  _selectPictureFromCamera (){
    if (!haveImage()) {
      _takePicture().then((path) {
        if (path!= null && path.isNotEmpty){
          File file = File(path);
          if (file .existsSync()) {
            print("拍摄的照片path: $path 拍摄的照片大小： ${file.lengthSync()}");
          }
          setState(() {
            currentImagePath = path;
          });
          _cropImage(path);
          controller.dispose();
        } else {
         print("Error: path is null");
        }
      });
    } else {
      setState(() {
        currentImagePath = null;
      });
      onNewCameraSelected(cameras.first);
    }
  }

  Future<String> _takePicture() async {
    if (!controller.value.isInitialized) {
      print('Error: initial first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/imgs/fapiao';
    await Directory(dirPath).create(recursive: true);
    final String filePath =
        '$dirPath/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
    print("filePath：${filePath}");
    print(
        "controller.value.isTakingPicture: ${controller.value.isTakingPicture}");
    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      print(e.code + "-----" + e.description);
      return null;
    }
    return filePath;
  }

  _selectPicture() async {
    var image = await ImagePicker.pickImage(
        imageQuality: Platform.isAndroid ? 70 : null,
//        maxWidth: 1624.0,
//        maxHeight: 1054.0,
        source: ImageSource.gallery);

    setState(() {
      currentImagePath = image.path;
    });

    _cropImage(image);
  }

  _cropImage(path) async {
//    File croppedFile = await ImageCropper.cropImage(
//      ratioX: 1.5,
//      ratioY: 1.0,
////        maxWidth: 1624,
////        maxHeight: 1054,
//      sourcePath: path,
//      toolbarTitle: '发票裁剪',
//      toolbarColor: Colors.black,
//      toolbarWidgetColor: Colors.white,
//    );
//    setState(() {
//      currentImagePath = croppedFile.path;
//    });
//    croppedFile.length().then((size) {
//      print(
//          "压缩之前的文件大小： ${size}，时间： ${DateTime.now().millisecondsSinceEpoch}");
//    });
  }
}
