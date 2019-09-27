import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(StartPage());

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

  @override
  void initState() {
    print("init state");
    _initCamera().then((cameras) {
      if (cameras != null) {
        onNewCameraSelected(cameras.first);
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
    print("didChangeAppLifecycleState--> ${state.toString()}");
    print(controller == null);
    print(!controller.value.isInitialized);
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      //if (controller != null) {
      onNewCameraSelected(controller.description);
      //}
    }
  }

  @override
  Widget build(BuildContext context) {
    var borderWidth = 30.0;
    var borderBgColor = Colors.black26;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: _previewWidget(),
                    width: double.infinity,
                  ),
                  Column(
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
                ],
              ),
            ),
            Container(
              height: 300.0,
              child: Row(
                children: <Widget>[
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _takePicture();
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        color: Colors.deepOrange,
                        child: Text("拍照"),
                      ),
                    ),
                  ),
                  Center(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewWidget() {
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
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    } else {
      return Container();
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.veryHigh,
    );

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

  Future<String> _takePicture() async {
    if (!controller.value.isInitialized) {
      print('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${ DateTime.now().millisecondsSinceEpoch.toString()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      print(e.code+"-----"+e.description);
      return null;
    }
    return filePath;
  }



_selectPicture() {
    print("从相册选择");
  }
}
