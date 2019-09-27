import 'package:flutter/material.dart';



void main()=> runApp(StartPage ());


class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LifeDemo(),
      ),
    );
  }
}


class LifeDemo extends StatefulWidget {
  @override
  _LifeDemoState createState() => _LifeDemoState();
}


class _LifeDemoState extends State<LifeDemo>
    with WidgetsBindingObserver {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print('initState');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("didChangeAppLifecycleState----> "+state.toString());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  void didUpdateWidget(LifeDemo oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    // TODO: implement build
    return MaterialApp(
      home: Center(
          child: GestureDetector(
            child: new Text('lifeCycle'),
            onTap: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (BuildContext c) {
                return new Text('sdfs');
              }));
            },
          )),
    );
  }
  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    print('reassemble');
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.addObserver(this);
    print('dispose');
  }
}
