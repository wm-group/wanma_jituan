import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/net/url_constant.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';
import 'package:wanma_jituan/common/redux/theme_data_reducer.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info/package_info.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonUtils {

  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color,platform: TargetPlatform.android);
  }

  ///store发送action，更新主题
  static pushTheme(Store store,int index) {
    ThemeData themeData;
    List<Color> colors = getThemeListColor();
    themeData = getThemeData(colors[index]);
    store.dispatch(RefreshThemeDataAction(themeData));
  }

  static List<Color> getThemeListColor() {
    return [
      WMColors.primarySwatch,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }
  //加载中
  static Future showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: WillPopScope(
            child: Center(
              child: Container(
                width: 200.0,
                height: 200.0,
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: SpinKitCubeGrid(color: Color(WMColors.white)),
                    ),
                    Container(height: 10.0,),
                    Container(
                      child: Text('加载中...',style: WMConstant.normalTextWhite,),
                    ),
                  ],
                ),
              ),
            ),
            onWillPop: () => Future.value(true),),
        );
      }
    );
  }

  ///更新提示弹窗
  static showUpdateDialog(context, flag) {
    _getContent() {
      switch(flag) {
        case 1:
          return Text('模块功能变动，重大更新！');
          break;
        case 2:
          return Text('新增修改模块功能！');
          break;
        case 3:
          return Text('修复运行时bug！');
          break;
        default:
          return Text('');
          break;
      }
    }

    _launchAPK() async {
      String url = Config.APK_ADDRESS;
      if(await canLaunch(url)) {
        await launch(url);
      }else {
        throw('下载异常！');
      }
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('版本更新'),
            content: _getContent(),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  if(flag == 1) {
                    SystemNavigator.pop();
                  }
                },
                child: new Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  _launchAPK();
                  Navigator.pop(context);
                },
                child: new Text('确认'),
              ),
            ],
          );
        }
    );

  }

  ///版本更新
  static checkVersion(context, bool showTip) async {
    if(Platform.isIOS) {
      return;
    }

    String serverVersion = await LocalStorage.get(Config.SERVER_VERSION);
    final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    String version = _packageInfo.version;
    if(Config.DEBUG) {
      print('serverVersion: $serverVersion');
      print('buildNumber: ${_packageInfo.buildNumber}');
      print('version: ${_packageInfo.version}');
    }

    List serverVersionList = serverVersion?.split('.');
    List versionList = version.split('.');
    if(double.parse(serverVersionList[0]) > double.parse(versionList[0])) {
      //修改功能过多，重大版本更新，强制更新
      showUpdateDialog(context, 1);
    }else if(double.parse(serverVersionList[1]) > double.parse(versionList[1])) {
      //修改或者新增功能，可以取消更新
      showUpdateDialog(context, 2);
    }else if(double.parse(serverVersionList[2]) > double.parse(versionList[2])) {
      //修改运行bug，可以取消更新
      showUpdateDialog(context, 3);
    }else {
      if(showTip) Fluttertoast.showToast(msg: 'app当前是最新版本，无需更新');
    }


  }


  ///单个底部菜单
  static renderTab(icon, text, {size, color}) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: size,color: color,),
          Padding(padding: EdgeInsets.all(2.0)),
          Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0),)
        ],
      ),
    );
  }
}