import 'package:mvp_module/model/IModelCallback.dart';

abstract class IBasePresenter extends IModelCallback {
  void customDispose();
}

abstract class IBaseView {

  void showLoading(bool);

//   void customDispose();

//   void onLoadSuccess(Object res, String tag);
//   void onLoadError(String errorMsg);

  void logout();

  void error (tag, String errorMsg){}
}
