import 'package:mvp_module/model/BaseModel.dart';
import 'package:mvp_module/presenter/IBaseContact.dart';

/// @author chenwei
/// create at 2019-06-14
/// description presenter的抽取层。
abstract class BasePresenter<T extends IBaseView, B extends BaseModel> extends IBasePresenter {
  BasePresenter(view) {
    this.view = view;
    model = getModel();
  }

  T view;
  B model;

  /*获取model实例*/
  B getModel ();

  @override
  void customDispose() {
    view = null;
  }

  @override
  void onTokenError() {
    super.onTokenError();
    if (view != null) {
      view.logout();
    }
  }

  @override
  void error(tag, String errorMsg) {
    super.error(tag, errorMsg);
    if (view != null) {
      view.showLoading(false);
      view.error(tag, errorMsg);
    }
  }
}
