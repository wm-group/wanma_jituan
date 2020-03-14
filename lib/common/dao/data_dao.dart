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
static Future getBasePriceData(bukrs) async {
  Map<String, dynamic> requestParams = {
    'bukrs': bukrs
  };
  var res = await HttpManager.netFetch(
      UrlConstant.getBasePrice(), requestParams, null, Options(method: 'post'));
  if (res != null && res.result) {
    return res.data;
  } else {
    return null;
  }
}
  //发货需求明细
  static Future getDeliverRequireData(vbeln) async{

    Map<String, dynamic> requestParams = {
      'vbeln': vbeln
    };

    var res = await HttpManager.netFetch(UrlConstant.getDeliverRequire(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      return res.data;
    }else {
      return null;
    }
  }

  //发货需求编辑页
  static Future getDeliverEditData(vbeln) async{

    Map<String, dynamic> requestParams = {
      'vbeln': vbeln
    };

    var res = await HttpManager.netFetch(UrlConstant.getDeliverEdit(), requestParams, null, Options(method: 'post'));
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
    
  }}

  //发货需求编辑页保存功能
  static Future deliverEditSave(userName, action, data) async{

    Map<String, dynamic> requestParams = {
      'user': userName,
      'action': action,
      'data': data
    };

    var res = await HttpManager.netFetch(UrlConstant.deliverRequireSubmit(), requestParams, null, Options(method: 'post'));
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

  //发货跟踪数据
  static Future getDeliveryTracking(bukrs) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
    };

    var res = await HttpManager.netFetch(UrlConstant.getDeliverTracking(), requestParams, null, Options(method: 'post'));
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
  //未开票
  static Future getNoSaleMessage(bukrs) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
    };

    var res = await HttpManager.netFetch(UrlConstant.getNoSaleMessage(), requestParams, null, Options(method: 'post'));
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

  //已开票
  static Future getSaleMessage(bukrs) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
    };

    var res = await HttpManager.netFetch(UrlConstant.getSaleMessage(), requestParams, null, Options(method: 'post'));
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

  //未开票明细
  static Future getNoSaleDetails(bukrs, kunnr, fhmonth) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
      'kunnr': kunnr,
      'fhmonth': fhmonth,
    };

    var res = await HttpManager.netFetch(UrlConstant.getNoSaleDetails(), requestParams, null, Options(method: 'post'));
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

  //已开票明细
  static Future getSaleDetails(bukrs, ticketnum) async{

    Map<String, dynamic> requestParams = {
      'bukrs': bukrs,
      'ticketnum': ticketnum,
    };

    var res = await HttpManager.netFetch(UrlConstant.getSaleDetails(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      return res.data;
    }else {
      return null;
    }


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
      return res.data;
    }else {
      return null;
    }
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
      return res.data;
    }else {
      return null;
    }
  }
}