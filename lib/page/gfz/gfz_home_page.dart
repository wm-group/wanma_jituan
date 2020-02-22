import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/db/provider/user_info_db_provider.dart';
import 'package:wanma_jituan/common/net/http_manager.dart';
import 'package:wanma_jituan/page/Gfz/gfz_order_page.dart';
import 'package:wanma_jituan/page/business_page.dart';
import 'package:wanma_jituan/page/home_page.dart';
import 'package:wanma_jituan/page/my_page.dart';
import 'package:wanma_jituan/page/service_page.dart';
import 'package:wanma_jituan/widget/home_drawer.dart';

///主页

class GfzHomePage extends StatefulWidget {
  static final String sName = 'home';
  final String mid;
  GfzHomePage(this.mid);

  @override
  _GfzHomePageState createState() => _GfzHomePageState();
}

class _GfzHomePageState extends State<GfzHomePage> with SingleTickerProviderStateMixin{

  var _currentIndex = 0;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _pageList = [
      GfzOrderPage(),
      ServicePage(),
      BusinessPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(Config.APP_TITLE),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(_currentIndex);
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            title: Text('业务'),
            icon: Icon(Icons.business),
          ),
          BottomNavigationBarItem(
            title: Text('工业4.0'),
            icon: Icon(Icons.build),
          ),
          BottomNavigationBarItem(
            title: Text('报表'),
            icon: Icon(Icons.list),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
//    tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}