import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:wanma_jituan/common/event/http_error_event.dart';
import 'package:wanma_jituan/common/model/User.dart';
import 'package:wanma_jituan/common/net/code.dart';
import 'package:wanma_jituan/common/redux/wm_state.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';
import 'package:wanma_jituan/common/utils/common_utils.dart';
import 'package:wanma_jituan/page/app.dart';
import 'package:wanma_jituan/page/home_page.dart';
import 'package:wanma_jituan/page/login_page.dart';
import 'package:wanma_jituan/page/welcome_page.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
//  debugPaintSizeEnabled = true; //打开视觉调试开关
  runApp(MyApp());

  //处理未捕获异常
  FlutterError.onError = (FlutterErrorDetails details) async {
    //转发到当前zone
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  //自定义错误提示页面
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      body: Center(
        child: Text('Custom Error Widget', style: TextStyle(color: Colors.red),),
      ),
    );
  };

  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    //do sth for error
    print('error: $error,/n stack: $stackTrace');
    //TODO
    //推送错误信息
  });

}

class MyApp extends StatelessWidget {

  /// 创建Store，引用 WMState 中的 appReducer 实现 Reducer 方法
  /// initialState 初始化 State
  final store = Store<WMState>(
    appReducer,
    ///初始化数据
    initialState: WMState(
      userInfo: User.empty(),
      themeData: CommonUtils.getThemeData(WMColors.primarySwatch),
    )
  );
  
  MyApp({Key key}) : super(key : key);
  
  @override
  Widget build(BuildContext context) {
    /// 通过 StoreProvider 应用 store
    return StoreProvider(
        store: store,
        child: StoreBuilder<WMState>(
            builder: (context, store) {
              return MaterialApp(
                title: '万马集团',
                theme: store.state.themeData,
                routes: {
                  WelcomePage.sName: (context) => WelcomePage(),
                  LoginPage.sName: (context) => CommonLayer(child: LoginPage(),),
                  App.sName: (context) => CommonLayer(child: App(),),
                },
//                home: CommonLayer(
//                  child: LoginPage(),
//                ),
              );
            }
        ),
    );
  }
}

class CommonLayer extends StatefulWidget {
  final Widget child;

  CommonLayer({this.child});

  @override
  _CommonLayerState createState() => _CommonLayerState();
}

class _CommonLayerState extends State<CommonLayer> {

  StreamSubscription stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //stream控制eventbus的使用
    stream = Code.eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    if(stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        Fluttertoast.showToast(msg: '网络错误');
        break;
      case Code.NETWORK_TIMEOUT:
        Fluttertoast.showToast(msg: '请求超时');
        break;
//      case 200:
//        Fluttertoast.showToast(msg: message);
//        break;
      case 401:
        Fluttertoast.showToast(msg: '[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]');
        break;
      case 403:
        Fluttertoast.showToast(msg: '403错误');
        break;
      case 404:
        Fluttertoast.showToast(msg: '404错误');
        break;
      default:
        Fluttertoast.showToast(msg: '其他异常 ' + message);
        break;
    }
  }
}


