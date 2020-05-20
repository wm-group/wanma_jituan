///接口地址
class UrlConstant {

  static const String host = 'http://app.wanmagroup.com:8988/';//正式
  static const String host2 = 'http://wms.wanmagroup.com/';//正式
//  static const String host = 'https://appdownload.wanmagroup.com:8443/';//测试
//  static const String host2 = 'http://itest.wanmagroup.com/';//测试
  
  ///登陆
  static getLogin() {
    return '${host}androidWeb/loginService/login.do';
  }

  ///高分子订单状态
  ///订单状态首页
  static getOrderData(flag) {
    return '$host$flag/GfzSdService/getOrderData.do';
  }

  ///订单明细
  static getOrderDetailsData(flag) {
    return '$host$flag/GfzSdService/getOrderGoodsDetail.do';
  }

  ///订单物流明细
  static getOrderGoodsFollow(flag) {
    return '$host$flag/GfzSdService/getGoodsFollowRecentData.do';
  }

  ///发货需求明细
  static getDeliverRequire(flag) {
    return '$host$flag/GfzSdService/getDeliverHisData.do';
  }

  ///发货需求编辑页
  static getDeliverEdit(flag) {
    return '$host$flag/GfzSdService/getDeliverEditData.do';
  }

  ///保存、提交、保存且提交
  ///action = 01 保存
  ///action = 03 提交、保存且提交
  static deliverRequireSubmit(flag) {
    return '$host$flag/GfzSdService/saveDeliverData.do';
  }

  ///历史发货需求
  static getDeliverHistory(flag) {
    return '$host$flag/GfzSdService/hisDataQuery.do';
  }

  ///高分子发货跟踪
  ///发货跟踪
  static getDeliverTracking(flag) {
    return '$host$flag/GfzSdService/fhgzMessage.do';
  }

  ///高分子开票情况
  ///未开票
  static getNoSaleMessage(flag) {
    return '$host$flag/GfzSdService/nosaledmessage.do';
  }

  ///未开票明细
  static getNoSaleDetails(flag) {
    return '$host$flag/GfzSdService/nosaleddetail.do';
  }

  ///已开票
  static getSaleMessage(flag) {
    return '$host$flag/GfzSdService/saledmessage.do';
  }

  ///已开票明细
  static getSaleDetails(flag) {
    return '$host$flag/GfzSdService/saleddetail.do';
  }

  ///高分子货款回笼
  ///货款回笼
  static getPaymentWithdrawal(flag) {
    return '$host$flag/GfzSdService/hkhl.do';
  }

  ///货款回笼明细
  static getPaymentDetails(flag) {
    return '$host$flag/GfzSdService/hkhldetail.do';
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
 static getIssueSituation(flag){
   return '$host$flag/GfzSdService/historymessage.do';
 }
//发出情况明细
static getCloseDetails(flag){
     return '$host$flag/GfzSdService/historymessagedetail.do';

}
//应收货款
static getTradeReceivable(flag){
    return '$host$flag/GfzSdService/yshk.do';
}
//应收货款明细
static getTradeDetail(flag){
    return '$host$flag/GfzSdService/yshkDetail.do';
}
//物流跟踪
static getLogisticsTracking(){
    return '${host}wmgfzandroid/GfzSdService/getGoodsWLData.do';
}
//物流明细
static getLogisticsDetail(){
    return '${host}wmgfzandroid/GfzSdService/signrecord/querybyorderno.do';
}
//高分子工业4.0
//异常查询
static getException(){
    return '${host}wmgfzandroid/GfzI4Service/getLineException.do';
}
//异常查询明细
static getExceptionDetail(){
    return '${host}wmgfzandroid/GfzI4Service/getLineDetaiException.do';
}
//异常查询-生产线运行日志-部门
static getExceptionProductDept(){
    return '${host}wmgfzandroid/GfzI4Service/getDeptList.do';
}
//生产线运行日志进度条数据
static getProductLine(){
    return '${host}wmgfzandroid/GfzI4Service/getWorkShopLine.do';
}
//生产线运行日志表格数据
static getProductLineTable(){
    return '${host}wmgfzandroid/GfzI4Service/getWorkShopLineChart.do';
}


  ///高分子工业4.0
  ///生产线列表首页
  static getLinesList() {
    return '${host}wmgfzandroid/GfzI4Service/getDeptWorkshopMes.do';
  }

  ///生产线列表
  static getLineList() {
    return '${host}wmgfzandroid/GfzI4Service/getLineList.do';
  }

  ///生产线详情页
  static getLineDetail() {
    return '${host}wmgfzandroid/GfzI4Service/getLineDetail.do';
  }

  ///历史运行曲线
  ///车间信息
  static getDeptList() {
    return '${host}wmgfzandroid/GfzI4Service/getDeptList.do';
  }

  ///生产线信息//dept

  ///参数信息
  static getParamList() {
    return '${host}wmgfzandroid/GfzI4Service/getCurrentData.do';
  }

  ///曲线信息
  static getLineHisData() {
    return '${host}wmgfzandroid/GfzI4Service/getHisData.do';
  }

//高分子报表

//成品入库
//车辆查询
static getCar(){
    return '${host2}car/rtWmCarService/service/8';
  }
  //车辆装货明细
static getCarGoods(){
    return '${host2}car/rtWmCarService/service/9';
  }
//修改车辆装货明细
static getUpdateCarGoods(){
    return '${host2}car/rtWmCarService/service/10';
  }

  ///原材料入库
  ///车牌下拉列表清单
  static getCarNoList() {
    return '${host2}car/rtWmCarService/service/0';
  }

  ///库位下拉列表清单
  static getWareList() {
    return '${host2}car/rtWmCarService/service/7';
  }

  ///入库明细数据
  static getWareDetail() {
    return '${host2}car/rtWmCarService/service/1';
  }

  ///拆分
  static detachMaterial() {
    return '${host2}car/rtWmCarService/service/5';
  }

  ///异常
  static reportException() {
    return '${host2}car/rtWmCarService/service/2';
  }

  ///入库
  static wareHouse() {
    return '${host2}car/rtWmCarService/service/4';
  }

///成品入库列表
  static getGoodsStorageList() {
    return '${host2}lot/rtLotInfo/lotEntry/1';
  }

///原材料入库列表
  static getMaterialStorageList() {
    return '${host2}lot/rtLotInfo/lotEntry/0';
  }

  ///特缆
  ///芯线生产量列表
  static getTLLineList(){
    return '${host}androidTl/industryTl4/getLine.do';
  }

  ///芯线详情页
  static getTLLineDetail(){
    return '${host}androidTl/industryTl4/getLineStatusDemo.do';
  }

  ///芯线曲线
  static getTLLineCurve(){
    return '${host}androidTl/industryTl4/getLineHisDemoN.do';
  }

  ///芯线月产量查询
  static getTLMonthQuery(){
    return '${host}androidTl/industryTl4/getLineMonthProdDataByYear.do';
  }

  ///芯线异常查询
  static getTLExceptionQuery(){
    return '${host}androidTl/industryTl4/getLineAlertCountByDates.do';
  }

  ///芯线异常明细
  static getTLExceptionDetail(){
    return '${host}androidTl/industryTl4/getLineAlertDetailsByDates.do';
  }

  ///菜单接口
  ///修改密码
  static updatePwd(){
    return '${host}androidWeb/loginService/changePwdNew.do';
  }
}