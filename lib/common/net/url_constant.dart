///接口地址
class UrlConstant {

  static const String host = 'http://app.wanmagroup.com:8988/';

  ///登陆
  static getLogin() {
    return '${host}androidWeb/loginService/login.do';
  }

  ///高分子订单状态
  ///订单状态首页
  static getOrderData() {
    return '${host}wmgfzandroid/GfzSdService/getOrderData.do';
  }

  ///订单明细
  static getOrderDetailsData() {
    return '${host}wmgfzandroid/GfzSdService/getOrderGoodsDetail.do';
  }

  ///订单物流明细
  static getOrderGoodsFollow() {
    return '${host}wmgfzandroid/GfzSdService/getGoodsFollowRecentData.do';
  }

  ///发货需求明细
  static getDeliverRequire() {
    return '${host}wmgfzandroid/GfzSdService/getDeliverHisData.do';
  }

  ///发货需求编辑页
  static getDeliverEdit() {
    return '${host}wmgfzandroid/GfzSdService/getDeliverEditData.do';
  }

  ///保存、提交、保存且提交
  ///action = 01 保存
  ///action = 03 提交、保存且提交
  static deliverRequireSubmit() {
    return '${host}wmgfzandroid/GfzSdService/saveDeliverData.do';
  }

  ///历史发货需求
  static getDeliverHistory() {
    return '${host}wmgfzandroid/GfzSdService/hisDataQuery.do';
  }

  ///高分子发货跟踪
  ///发货跟踪
  static getDeliverTracking() {
    return '${host}wmgfzandroid/GfzSdService/fhgzMessage.do';
  }

  ///高分子开票情况
  ///未开票
  static getNoSaleMessage() {
    return '${host}wmgfzandroid/GfzSdService/nosaledmessage.do';
  }

  ///未开票明细
  static getNoSaleDetails() {
    return '${host}wmgfzandroid/GfzSdService/nosaleddetail.do';
  }

  ///已开票
  static getSaleMessage() {
    return '${host}wmgfzandroid/GfzSdService/saledmessage.do';
  }

  ///已开票明细
  static getSaleDetails() {
    return '${host}wmgfzandroid/GfzSdService/saleddetail.do';
  }

  ///高分子货款回笼
  ///货款回笼
  static getPaymentWithdrawal() {
    return '${host}wmgfzandroid/GfzSdService/hkhl.do';
  }

  ///货款回笼明细
  static getPaymentDetails() {
    return '${host}wmgfzandroid/GfzSdService/hkhldetail.do';
  }

  ///高分子基准价
  ///基准价
  static getBasePrice(){
    return '${host}wmgfzandroid/GfzSdService/jzjmessage.do';

  }

  //目标情况
  static getTargetSituation(){
    return '${host}wmgfzandroid/GfzSdService/targetmessage.do';

  }
//发出情况
 static getIssueSituation(){
   return '${host}wmgfzandroid/GfzSdService/historymessage.do';
 }
//发出情况明细
static getCloseDetails(){
     return '${host}wmgfzandroid/GfzSdService/historymessagedetail.do';

}
//应收货款
static getTradeReceivable(){
    return '${host}wmgfzandroid/GfzSdService/yshk.do';
}
//应收货款明细
static getTradeDetail(){
    return '${host}wmgfzandroid/GfzSdService/yshkDetail.do';
}
//物流跟踪
static getLogisticsTracking(){
    return '${host}wmgfzandroid/GfzSdService/getGoodsWLData.do';
}
//物流明细
static getLogisticsDetail(){
    return '${host}wmgfzandroid/GfzSdService/signrecord/querybyorderno.do';
}


  ///菜单接口
  ///修改密码
  static updatePwd() {
    return '${host}androidWeb/loginService/changePwdNew.do';
  }

}