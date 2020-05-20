import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/page/ty/ty_industry_page.dart';
import 'package:wanma_jituan/page/ty/ty_order_page.dart';
import 'package:wanma_jituan/page/ty/ty_reportform_page.dart';

///主页

class TYHomePage extends StatefulWidget {
  final String mid;
  TYHomePage(this.mid);

  @override
  _TYHomePageState createState() => _TYHomePageState();
}

class _TYHomePageState extends State<TYHomePage> with SingleTickerProviderStateMixin{

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
      TYOrderPage(),
      TYIndustryPage(),
      TYReportFormPage(),
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