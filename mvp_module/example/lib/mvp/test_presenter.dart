

import 'package:mvp_module/presenter/BasePresenter.dart';
import 'package:example/mvp/test_contract.dart';
import 'package:example/mvp/custom_model.dart';
import 'package:example/mvp/bean/news_info_entity.dart';


class TestPresenter extends BasePresenter<ITestView, CustomModel> implements ITestPresenter {
  TestPresenter(view) : super(view);



  @override
  CustomModel getModel() {
    return CustomModel();
  }


  @override
  void success(tag, response) {
    super.success(tag, response);
    if("TAG_LOAD_CITY_LIST" == tag){
      List<NewsInfoEntity> list = [];
      response?.data?.forEach((v){
        list.add(NewsInfoEntity.fromJson(v));
      });

      if(view != null) view.getNewsSuccess(list);
    }
  }
  @override
  void error(tag, String errorMsg) {
    super.error(tag, errorMsg);
  }

  @override
  void getNewsList() {
    String url ="https://unidemo.dcloud.net.cn/api/news";
    model.getRequest(url, null, this, "TAG_LOAD_CITY_LIST");
  }

}

class NewsInfo {

}
