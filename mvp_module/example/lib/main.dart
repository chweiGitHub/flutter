import 'package:flutter/material.dart';

import 'package:example/mvp/custom_state.dart';
import 'mvp/test_contract.dart';
import 'mvp/test_presenter.dart';
import 'mvp/bean/news_info_entity.dart';

void main() => runApp(Start());

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends CustomState<TestPresenter, MainPage>
    implements ITestView {
  List<Widget> listWidget = [];

  @override
  void initState() {
    super.initState();
    if (presenter != null) {
      presenter.getNewsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mvp_module_title"),
      ),
      body: ListView(
        children: listWidget,
      ),
    );
  }

  @override
  void initPresenter() {
    presenter = TestPresenter(this);
  }

  @override
  void getNewsSuccess(List<NewsInfoEntity> list) {
    List<Widget> vs = [];
    list?.forEach((NewsInfoEntity data) {
      vs.add(
        Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(
                  data.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  data.content,
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                color: Colors.red,
                height: 1.0,
              ),
            ],
          ),
        ),
      );
    });
    setState(() {
      listWidget = vs;
    });
  }
}
