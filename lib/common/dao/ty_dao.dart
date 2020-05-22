import 'package:dio/dio.dart';
import 'package:wanma_jituan/common/net/http_manager.dart';
import 'package:wanma_jituan/common/net/url_constant.dart';

class TYDao {

  ///天屹
  //半成品盘点信息
  static Future getTYInventoryMessage(sk, barcode) async {
    Map<String, dynamic> requestParams = {
      '_SK_': sk,
      'barcode': barcode
    };
    var res = await HttpManager.netFetch(
        UrlConstant.getTYInventoryMessage(), requestParams, null,
        Options(method: 'post'));
    if (res != null && res.result) {
      if (res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }

  //半成品盘点确认
  static Future getTYInventorySure(sk, barcode, recId) async {
    Map<String, dynamic> requestParams = {
      '_SK_': sk,
      'barcode': barcode,
      'recipe_id': recId
    };
    var res = await HttpManager.netFetch(
        UrlConstant.getTYInventorySure(), requestParams, null,
        Options(method: 'post'));
    if (res != null && res.result) {
      if (res.data != null && res.data != '') {
        return res.data;
      }
    }
    return null;
  }
}