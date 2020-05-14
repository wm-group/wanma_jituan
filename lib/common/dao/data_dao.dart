import 'package:dio/dio.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
import 'package:wanma_jituan/common/net/http_manager.dart';
import 'package:wanma_jituan/common/net/url_constant.dart';

///获取订单状态数据
class DataDao {

  static Future getAuthority(userName, password) async {
    var url = 'http://app.wanmagroup.com:8988/wmgfzandroid/loginService/subsystem/login.do?userId=$userName&password=$password';
    await HttpManager.netFetch(url, null, null, Options(method: 'get'));
  }

  //订单状态首页数据
  static Future getOrderData(bukrs, s_date, e_date) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
      's_date': s_date,
      'e_date': e_date,
    };

//    String url = UrlConstant.getOrderData() + '?bukrs=$bukrs&s_date=$s_date&e_date=$e_date';
    var res = await HttpManager.netFetch(UrlConstant.getOrderData(), requestParams, null, Options(method: 'post'));
//    OrderStatusModel orderStatusModel;
//    if(res != null && res.result) {
//      try{
//        orderStatusModel = OrderStatusModel.fromJson(json.decode(res.data));
//        return orderStatusModel;
//      }catch(e) {
//      }
//    }
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //订单明细数据
  static Future getOrderDetailsData(bukrs, vbeln) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
      'vbeln': vbeln,
    };

    var res = await HttpManager.netFetch(UrlConstant.getOrderDetailsData(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //订单物流跟踪数据
  static Future getOrderGoodsData(bukrs, vbeln, posnr) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
      'posnr': posnr,
      'vbeln': vbeln
    };

    var res = await HttpManager.netFetch(UrlConstant.getOrderGoodsFollow(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //基准价数据
  static Future getBasePriceData(bukrs) async {
    Map<String, dynamic> requestParams = {
      'bukrs': bukrs
    };
    var res = await HttpManager.netFetch(
        UrlConstant.getBasePrice(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //发货需求明细
  static Future getDeliverRequireData(vbeln) async{

    Map<String, dynamic> requestParams = {
      'vbeln': vbeln
    };

    var res = await HttpManager.netFetch(UrlConstant.getDeliverRequire(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //发货需求编辑页
  static Future getDeliverEditData(vbeln) async{

    Map<String, dynamic> requestParams = {
      'vbeln': vbeln
    };

    var res = await HttpManager.netFetch(UrlConstant.getDeliverEdit(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //历史发货需求
  static Future getDeliverHistoryData() async{

    var res = await HttpManager.netFetch(UrlConstant.getDeliverHistory(), null, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //目标情况数据
  static Future getTargetSituationData(bukrs,month) async{
    Map<String,dynamic> requestParams = {
      'bukrs':bukrs,
      'month':month
    };
    var res = await HttpManager.netFetch(UrlConstant.getTargetSituation(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //发出情况数据
  static Future getIssueSituationData(bukrs) async{
    Map<String,dynamic> requestParams = {
      'bukrs':bukrs,
    };
    var res = await HttpManager.netFetch(UrlConstant.getIssueSituation(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //发货需求编辑页保存功能
  static Future deliverEditSave(userName, action, data) async{

    Map<String, dynamic> requestParams = {
      'user': userName,
      'action': action,
      'data': data
    };

    var res = await HttpManager.netFetch(UrlConstant.deliverRequireSubmit(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;

  }

  //发出情况明细数据
  static Future getCloseDetailsData(bukrs,date,kunnr) async{
    Map<String,dynamic> requestParams = {
      'Bukrs':bukrs,
      'date':date,
      'kunnr':kunnr,
    };
    var res = await HttpManager.netFetch(UrlConstant.getCloseDetails(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //发货跟踪数据
  static Future getDeliveryTracking(bukrs) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
    };

    var res = await HttpManager.netFetch(UrlConstant.getDeliverTracking(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;

  }

  //应收货款数据
  static Future getTradeReceivableData(bukrs,date1,date2) async{
    Map<String,dynamic> requestParams = {
      'bukrs':bukrs,
      's_date':date1,
      'e_date':date2,
    };
    var res = await HttpManager.netFetch(UrlConstant.getTradeReceivable(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //未开票
  static Future getNoSaleMessage(bukrs) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
    };

    var res = await HttpManager.netFetch(UrlConstant.getNoSaleMessage(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //应收货款明细数据
  static Future getTradeDetailData(bukrs,kunnr) async{
    Map<String,dynamic> requestParams = {
      'bukrs':bukrs,
      'kunnr':kunnr,
    };
    var res = await HttpManager.netFetch(UrlConstant.getTradeDetail(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //已开票
  static Future getSaleMessage(bukrs) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
    };

    var res = await HttpManager.netFetch(UrlConstant.getSaleMessage(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //物流跟踪数据
  static Future getLogisticsTrackingData(bukrs,date2,date1) async{
    Map<String,dynamic> requestParams = {
      'bukrs':bukrs,
      'e_date':date2,
      's_date':date1,
    };
    var res = await HttpManager.netFetch(UrlConstant.getLogisticsTracking(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //未开票明细
  static Future getNoSaleDetails(bukrs, kunnr, fhmonth) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
      'kunnr': kunnr,
      'fhmonth': fhmonth,
    };

    var res = await HttpManager.netFetch(UrlConstant.getNoSaleDetails(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;


  }

  //物流跟踪明细数据
  static Future getLogisticsDetailData( order_no) async{
    Map<String,dynamic> requestParams = {
      'order_no':order_no,
    };
    var res = await HttpManager.netFetch(UrlConstant.getLogisticsDetail(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //已开票明细
  static Future getSaleDetails(bukrs, ticketnum) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
      'ticketnum': ticketnum,
    };

    var res = await HttpManager.netFetch(UrlConstant.getSaleDetails(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;


  }

  //货款回笼
  static Future getPaymentWithdrawal(bukrs, sDate, eDate) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
      's_date': sDate,
      'e_date': eDate,
    };

    var res = await HttpManager.netFetch(UrlConstant.getPaymentWithdrawal(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //货款回笼明细
  static Future getPaymentDetails(bukrs, sDate, eDate, kunnr) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
      's_date': sDate,
      'e_date': eDate,
      'kunnr': kunnr
    };

    var res = await HttpManager.netFetch(UrlConstant.getPaymentDetails(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //工业4.0
  //异常查询-生产线运行日志
  static Future getException(dept, lineDate,url) async{
    Map<String, dynamic> requestParams = {
      'dept': dept,
      'lineDate': lineDate,
    };
    var res = await HttpManager.netFetch(url, requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  ///高分子工业4.0
  //生产线列表
  static Future getLinesListData(bukrs) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
    };

    var res = await HttpManager.netFetch(UrlConstant.getLinesList(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //异常查询明细
  static Future getExceptionDetail(line_no, lineDate) async{
    Map<String, dynamic> requestParams = {
      'line_no': line_no,
      'lineDate': lineDate,
    };
    var res = await HttpManager.netFetch(UrlConstant.getExceptionDetail(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //生产线列表
  static Future getLineListData(department) async{

    Map<String, dynamic> requestParams = {
      'dept': department,
    };

    var res = await HttpManager.netFetch(UrlConstant.getLineList(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //异常查询_生产线运行日志_部门列表
  static Future getExceptionProductDept(bukrs) async{
    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
    };
    var res = await HttpManager.netFetch(UrlConstant.getExceptionProductDept(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //生产线详细
  static Future getLineDetail(lineNo) async{

    Map<String, dynamic> requestParams = {
      'line_no': lineNo,
    };

    var res = await HttpManager.netFetch(UrlConstant.getLineDetail(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //历史运行曲线
  //车间列表
  static Future getDeptList(bukrs) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
    };

    var res = await HttpManager.netFetch(UrlConstant.getDeptList(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //参数列表
  static Future getParamList(lineName) async{

    Map<String, dynamic> requestParams = {
      'line_name': lineName,
    };

    var res = await HttpManager.netFetch(UrlConstant.getParamList(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //历史曲线数据
  static Future getLineHisData(department, lineName, param, lineDate) async{

    Map<String, dynamic> requestParams = {
      'dept': department,
      'line_name': lineName,
      'point': param,
      'lineDate': lineDate,
    };

    var res = await HttpManager.netFetch(UrlConstant.getLineHisData(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }
  //报表

  //成品入库
  //车辆查询
  static Future getCar()async{
    var _sk = await LocalStorage.get(Config.SET_KEY);
    Map<String, String>requestParams={
      '_SK_':_sk
    };
    var res = await HttpManager.netFetch(UrlConstant.getCar(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //车辆装货明细
  static Future getCarGoods(inoutId)async{
    var _sk = await LocalStorage.get(Config.SET_KEY);
    Map<String, String>requestParams={
      'inoutId':inoutId,
      '_SK_':_sk
    };
    var res = await HttpManager.netFetch(UrlConstant.getCarGoods(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //修改车辆装货明细
  static Future getUpdateCarGoods(loadingIds,qtys)async{
    var _sk = await LocalStorage.get(Config.SET_KEY);
    Map<String, String>requestParams={
      'loadingIds':loadingIds,
      'qtys':qtys,
      '_SK_':_sk
    };
    var res = await HttpManager.netFetch(UrlConstant.getUpdateCarGoods(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //成品入库列表
  static Future getGoodsStorageList(_sk) async {
    Map<String, String>requestParams={
      '_SK_':_sk,
    };
    var res = await HttpManager.netFetch(UrlConstant.getGoodsStorageList(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //原材料入库
  //车牌信息
  static Future getCarNoList(_sk) async {

    Map<String, String>requestParams={
      '_SK_':_sk
    };

    var res = await HttpManager.netFetch(UrlConstant.getCarNoList(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //库位信息
  static Future getWareList(_sk, plateNumber) async {

    Map<String, String>requestParams={
      '_SK_':_sk,
      'plate_number': plateNumber
    };

    var res = await HttpManager.netFetch(UrlConstant.getWareList(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //入库明细数据
  static Future getWareDetail(_sk, wareId, inoutId, purpose) async {

    Map<String, String>requestParams={
      '_SK_':_sk,
      'ware_id': wareId,
      'inout_id': inoutId,
      'purpose': purpose
    };

    var res = await HttpManager.netFetch(UrlConstant.getWareDetail(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //拆分
  static Future detachMaterial(_sk, carId, carLoadingId, wareId, detachNum, batch) async {

    Map<String, String>requestParams={
      '_SK_':_sk,
      'carId': carId,
      'carLoadingId': carLoadingId,
      'ware_id': wareId,
      'qty': detachNum,
      'batch': batch
    };

    var res = await HttpManager.netFetch(UrlConstant.detachMaterial(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //异常
  static Future reportException(_sk, inoutId, loadingId, causeId) async {

    Map<String, String>requestParams={
      '_SK_':_sk,
      'inout_id': inoutId,
      'loading_id': loadingId,
      'cause_id': causeId
    };

    var res = await HttpManager.netFetch(UrlConstant.reportException(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //入库
  static Future wareHouse(_sk, loadingId, actualNum, batch, wareId, packs, unit) async {

    Map<String, String>requestParams={
      '_SK_':_sk,
      'loading_ids': loadingId,
      'curr_qtys': actualNum,
      'batchs': batch,
      'ware_id': wareId,
      'part_pack_weights': packs,
      'zbzgg': unit
    };

    var res = await HttpManager.netFetch(UrlConstant.wareHouse(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

}