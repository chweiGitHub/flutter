

// @author chenwei
// create at 2019/5/22
// description  定义app上显示的各种固定文案、标题、提示语等。
class Strings {

  static const String appName ="雁工云";
  static const String companyName ="普道科技";

  // 5个主menu要显示的title
  static const String home ="首页";
  static const String message ="消息";
  static const String task ="发任务";
  static const String report ="统计";
  static const String userCenter ="我的";

  static const String allTask ="全部任务";
  static const String eligibleTask ="可领取任务";
  static const String taskDetail ="任务详情";
  static const String taskLog ="任务记录";

//  任务操作按钮文案
  static const String immediatelyReceive ="立即领取";
  static const String taskComplete ="完成任务";
  static const String received ="已被领取";

//  任务列表title
  static const String taskListTitleAllTask ="全部";
  static const String taskListTitleProgressingn ="进行中";
  static const String taskListTitleWaitSettle ="待结算";
  static const String taskListTitleFinished ="已结算";
  static const String taskListEmptyTitle ="暂无记录";

  // 任务详情
  static const String taskName="任务名称";
  static const String taskState="任务状态";
  static const String taskBudget="需求预算";
  static const String taskDescription="任务描述";
  static const String taskStatus="任务状态";
  static const String taskCreator="任务创建人";
  static const String taskRepeat="重复领取";
  static const String taskCreateDate="创建时间";
  static const String taskStartTime="开始时间";
  static const String taskEndTime="结束时间";
  static const String taskHistoryLog="任务记录";
  static const String taskUserName="员工姓名";
  static const String taskPhoneNum="电话";
  static const String taskReceiveTime="领取时间";
  static const String settle="结算";
  static const String batchSettlement="批量结算";
  static const String receiveTaskSuccess ="领取成功！";
  static const String receiveTaskConfirmInfo ="确认要领取该任务吗？";
  static const String completeTaskConfirmInfo ="确认要完成该任务吗？";
  static const String receiveTaskSuccessV2 ="任务领取成功";
  static const String completeTaskSuccess ="恭喜任务已完成";


  // 发布任务
  static const String createTaskTitle="新任务";
  static const String createTaskOptionTitle="指定领取人";
  static const String createTaskMoney="任务金额";
  static const String createTaskReceiveSet="领取设置";
  static const String createTaskReceiveCnt="任务数量";
  static const String createTaskReceiveType="指定领取";
  static const String createSelDate="选择日期";
  static const String createTaskSelUser="指定领取人";
  static const String createTaskSetRepeat="重复设置";
  static const String canNotRepeat="不可重复领取";
  static const String setRepeatType="请设置重复方式";
  static const String canRepeat="可重复领取";
  static const String taskStartDate="开始日期";
  static const String taskEndDate="结束日期";
  static const String taskSaveAndPublish="保存并发布";
  static const String taskSaveAndNext="保存并执行下一步";
  static const String taskSaveAndPrevious="上一步";
  static const String taskSelectUserTitle="选择领取人";
  static const String showSelectedUsersDlgTitle ="已选组或人员";
  static const String receiveOnlyOneTag ="每个账户只能领取该任务一次";
  static const String receiveMultiTag ="每个账户可多次领取该任务";
  static const String createTask ="发布";


  // 我
  static const String all ="全部";
  static const String taskIPosted ="我发布的任务";
  static const String taskIReceived ="我领取的任务";
  static const String waitReceived ="待领取";
  static const String waitSettle ="进行中";
  static const String unCompleted ="未完成";
  static const String completed ="已完成";
  static const String finished ="已结算";
  static const String waitFinished ="待结算";
  static const String lookAll ="查看全部 >";
  static const String userProfile ="个人资料";



  // 个人信息页面
  static const String userAvatarTitle ="头像";
  static const String userNameTitle ="姓名";
  static const String phoneTitle ="手机号码";
  static const String emailTitle ="邮箱";
  static const String genderTitle ="性别";
  static const String dateOfBirthTitle ="出生日期";
  static const String descriptionTitle ="描述";
  static const String addressTitle ="地址";
  static const String genderMale ="男";
  static const String genderFemal ="女";
  static const String save ="保存";
  static const String emailNotRightToast ="请输入正确的邮箱！";


  static const String modifyNameTitle ="更改姓名";
  static const String modifyNameHint ="请填写您的真实姓名";
  static const String modifyEmailTitle ="更改邮箱";
  static const String modifyEmailHint ="请填写您的真实邮箱";
  static const String modifyDescriptionTitle ="更改描述";
  static const String modifyDescriptionHint ="请填写您的详细描述";
  static const String modifyAddressTitle ="更改地址";
  static const String modifyAddressHint ="请填写您的联系地址";

  static const String takePhone ="拍照";
  static const String selectImageFromAlbum ="从相册选择";

  // 我的消息
  static const String messageListPageTitle ="我的消息";

  // 弹框
  static const String dlgCancle ="取消";
  static const String dlgConfirm ="确定";

  // 登录
  static const String companyFullName = "普道（上海）信息科技有限公司";
  static const String inputPhonePh = "请输入手机号";
  static const String nextStep = "下一步";
  static const String findPwdBack = "找回密码";
  static const String inputCodePh = "请输入验证码";
  static const String getCode = "获取验证码";
  static const String resetPwd = "重置密码";
  static const String inputPwdPh = "请输入密码";
  static const String confirmPwdPh = "请输入确认密码";
  static const String done = "完成";
  static const String reg_tip = "您还未成为雁工云用户，请注册！";
  static const String newUserReg = "新用户注册";
  static const String regDone = "完成注册";
  static const String loginConfirm = "登录验证";
  static const String forgotPwd = "忘记密码？";
  static const String login = "登录";

  // 搜索
  static const String search ="搜索";
  static const String searchCancel ="取消";
  static const String searchHistoryLog ="搜索历史";
  static const String  searchTaskTitle ="任务";
  static const String searchTaskhint ='请输入要搜索的任务';
  static const String searchPageEmptyInfo ='暂无搜索结果';


  static const String defaultHeader ="https://flutterchina.club/images/catalog-widget-placeholder.png";


  static const String exit ='退出登录';




}