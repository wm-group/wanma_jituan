import 'package:dio/dio.dart';
import 'package:wanma_jituan/common/model/app_menu_model.dart';
import 'package:wanma_jituan/common/model/gfz/order_status_model.dart';
import 'package:wanma_jituan/common/net/http_manager.dart';
import 'package:wanma_jituan/common/net/url_constant.dart';
import 'dart:convert';

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
      return res.data;
    }else {
      return null;
    }
  }

  //订单明细数据
  static Future getOrderDetailsData(bukrs, vbeln) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
      'vbeln': vbeln,
    };

    var res = await HttpManager.netFetch(UrlConstant.getOrderDetailsData(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      return res.data;
    }else {
      return null;
    }
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
      return res.data;
    }else {
      return null;
    }
  }
//基准价数据
static Future getBasePriceData(bukrs) async{
  Map<String,dynamic> requestParams = {
    'bukrs':bukrs
  };
  var res = await HttpManager.netFetch(UrlConstant.getBasePrice(), requestParams, null, Options(method: 'post'));
   if(res != null && res.result) {
      return res.data;
    }else {
      return null;
    }

}

//目标情况数据
static Future getTargetSituationData(bukrs,month) async{
  Map<String,dynamic> requestParams = {
    'bukrs':bukrs,
    'month':month
  };
  var res = await HttpManager.netFetch(UrlConstant.getTargetSituation(), requestParams, null, Options(method: 'post'));
   if(res != null && res.result) {
      return res.data;
    }else {
      return null;
    }

}
//发出情况数据
static Future getIssueSituationData(bukrs) async{
  Map<String,dynamic> requestParams = {
    'bukrs':bukrs,
  };
  var res = await HttpManager.netFetch(UrlConstant.getIssueSituation(), requestParams, null, Options(method: 'post'));
   if(res != null && res.result) {
      return res.data;
    }else {
      return null;
    }

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
      return res.data;
    }else {
      return null;
    }

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
      return res.data;
    }else {
      return null;
    }

}

//应收货款明细数据
static Future getTradeDetailData(bukrs,kunnr) async{
   Map<String,dynamic> requestParams = {
    'bukrs':bukrs,
    'kunnr':kunnr,
  };
  var res = await HttpManager.netFetch(UrlConstant.getTradeDetail(), requestParams, null, Options(method: 'post'));
   if(res != null && res.result) {
      return res.data;
    }else {
      return null;
    }

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
      return res.data;
    }else {
      return null;
    }

}

//物流跟踪明细数据
static Future getLogisticsDetailData( order_no) async{
   Map<String,dynamic> requestParams = {
    'order_no':order_no,
  };
  var res = await HttpManager.netFetch(UrlConstant.getLogisticsDetail(), requestParams, null, Options(method: 'post'));
   if(res != null && res.result) {
      return res.data;
    }else {
      return null;
    }

}
}