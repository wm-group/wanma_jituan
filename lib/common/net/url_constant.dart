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


  ///菜单接口
  ///修改密码
  static updatePwd() {
    return '${host}androidWeb/loginService/changePwdNew.do';
  }

  //基准价
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
}