import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';


void main ()=> runApp(MyApp ());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: FirstPage (),
    );
  }
}
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  FlutterTts flutterTts;

  Future _speak() async{
    var result = await flutterTts.speak("");
    print("result: $result");
    //if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stop() async{
    var result = await flutterTts.stop();
   // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void initState() {
    flutterTts = new FlutterTts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("tts demo"),),
      body:  Container(

      ),
      floatingActionButton: FloatingActionButton(child: Text("播放"), onPressed: (){_speak();  },),
    );
  }
}

