import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/db/provider/user_info_db_provider.dart';
import 'package:wanma_jituan/common/net/http_manager.dart';
import 'package:wanma_jituan/page/business_page.dart';
import 'package:wanma_jituan/page/home_page.dart';
import 'package:wanma_jituan/page/my_page.dart';
import 'package:wanma_jituan/page/service_page.dart';
import 'package:wanma_jituan/widget/home_drawer.dart';

///主页

class App extends StatefulWidget {
  static final String sName = 'home';

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin{

  var _currentIndex = 0;

  PageController _pageController;

  var _futureStr;

  /// 提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('确定要退出应用？'),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('取消')
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('确定')
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
//    UserInfoDbProvider provider = UserInfoDbProvider();
//    provider.queryUser('2005');
  }

  @override
  Widget build(BuildContext context) {

  return WillPopScope(
    child: Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(Config.APP_TITLE),
      ),
      body: HomePage(),
    ),
    onWillPop: () => _dialogExitApp(context),
  );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
