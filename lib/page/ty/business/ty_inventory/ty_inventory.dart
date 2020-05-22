import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class TYInventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TYInventoryBody(),
    );
  }
}

class TYInventoryBody extends StatefulWidget {
  @override
  _TYInventoryBodyState createState() => _TYInventoryBodyState();
}

class _TYInventoryBodyState extends State<TYInventoryBody> {

  var _sk;
  var barcode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scan();
  }

  _scan() async {
    _sk = await LocalStorage.get(Config.SET_KEY);
    if(_sk == null) {
      Fluttertoast.showToast(msg: '请去参数设置菜单设置SK值');
      Navigator.of(context).pop();
    }else {
      try {
        String barcode = await BarcodeScanner.scan();
        if(barcode != null) {
          NavigatorUtils.goTYInventoryMessage(context, _sk, barcode);
        }
      } on PlatformException catch (e) {
        if (e.code == BarcodeScanner.CameraAccessDenied) {
          barcode = null;
          Fluttertoast.showToast(msg: '用户没有开通照相机权限');
        } else {
          barcode = null;
          Fluttertoast.showToast(msg: '不知错误：$e');
        }
      } on FormatException{
        barcode = null;
      } catch (e) {
        barcode = null;
        Fluttertoast.showToast(msg: '不知错误：$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}