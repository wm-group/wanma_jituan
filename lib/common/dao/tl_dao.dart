import 'package:dio/dio.dart';
import 'package:wanma_jituan/common/net/http_manager.dart';
import 'package:wanma_jituan/common/net/url_constant.dart';

class TLDao {

  ///芯线生产量列表
  //生产线列表
  static Future getTLLineList(bukrs) async {
    Map<String, dynamic> requestParams = {
      'bukrs': bukrs
    };
    var res = await HttpManager.netFetch(
        UrlConstant.getTLLineList(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //生产线详情页
  static Future getTLLineDetail(lineNo, dateStr) async {
    Map<String, dynamic> requestParams = {
      'lineNo': lineNo,
      'lineDate': dateStr
    };
    var res = await HttpManager.netFetch(
        UrlConstant.getTLLineDetail(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //生产线曲线
  static Future getTLLineCurve(lineNo, dateStr, timeStr) async {
    Map<String, dynamic> requestParams = {
      'lineNo': lineNo,
      'lineDate': dateStr,
      'lineTime': timeStr
    };
    var res = await HttpManager.netFetch(
        UrlConstant.getTLLineCurve(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  ///芯线月产量查询
  //月产量查询
  static Future getTLMonthQuery(year) async {
    Map<String, dynamic> requestParams = {
      'prodYear': year
    };
    var res = await HttpManager.netFetch(
        UrlConstant.getTLMonthQuery(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  ///芯线异常查询
  //异常查询统计
  static Future getTLExceptionQuery(startDate, endDate) async {
    Map<String, dynamic> requestParams = {
      'startDate': startDate,
      'endDate': endDate
    };
    var res = await HttpManager.netFetch(
        UrlConstant.getTLExceptionQuery(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //异常查询明细
  static Future getTLExceptionDetail(startDate, endDate, lineNo) async {
    Map<String, dynamic> requestParams = {
      'startDate': startDate,
      'endDate': endDate,
      'lineNo': lineNo
    };
    var res = await HttpManager.netFetch(
        UrlConstant.getTLExceptionDetail(), requestParams, null, Options(method: 'post'));
    if(res != null && res.result) {
      if(res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }
}