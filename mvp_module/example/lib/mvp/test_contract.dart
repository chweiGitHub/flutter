


import 'package:mvp_module/presenter/IBaseContact.dart';
import 'package:example/mvp/bean/news_info_entity.dart';

abstract class ITestView extends IBaseView {
  void getNewsSuccess (List<NewsInfoEntity> list);
}

abstract class ITestPresenter extends IBasePresenter {
  // 获取新闻列表
  void getNewsList ();
}