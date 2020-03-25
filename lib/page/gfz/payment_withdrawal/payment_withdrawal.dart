import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';
import 'package:date_format/date_format.dart';

class PaymentWithdrawal extends StatefulWidget {
  @override
  _PaymentWithdrawalState createState() => _PaymentWithdrawalState();
}

class _PaymentWithdrawalState extends State<PaymentWithdrawal> {
  String _bodyStr = '最近一周';
  int flag = 1;

  Future _futureStr;

  List dataList;
  int _sortColumnIndex;
  bool _sortAscending = true;

  List<dynamic> receiveList = [];
  List<dynamic> backList =[];
  List<dynamic>  selectNameList = [];//选择数据

  bool _isSearch = false;
  IconData _searchIcon = Icons.search;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureStr = _getPaymentWithdrawal();
  }

  Future _getPaymentWithdrawal() async {
    String bukrs = '1008';
    var today = DateTime.now();
    var weekAgoDate = today.add(Duration(days: -7));
    var monthAgoDate = today.add(Duration(days: -30));
    var thirtyAgoDate = today.add(Duration(days: -90));

    String sDate = formatDate(weekAgoDate, [yyyy, '-', mm, '-', dd]);
    String eDate = formatDate(today, [yyyy, '-', mm, '-', dd]);

    selectNameList = [];
    receiveList = [];
    if(selectNameList.isNotEmpty) {
      selectNameList.clear();
    }
    switch(flag) {
      case 1:
        sDate = formatDate(weekAgoDate, [yyyy, '-', mm, '-', dd]);
        var data = await DataDao.getPaymentWithdrawal(bukrs, sDate, eDate);
        for (var item in data) {
          selectNameList.add(item['customer']);
        }
        return data;
        break;
      case 2:
        sDate = formatDate(monthAgoDate, [yyyy, '-', mm, '-', dd]);
        var data = await DataDao.getPaymentWithdrawal(bukrs, sDate, eDate);
        for (var item in data) {
          selectNameList.add(item['customer']);
        }
        return data;
        break;
      case 3:
        sDate = formatDate(thirtyAgoDate, [yyyy, '-', mm, '-', dd]);
        var data = await DataDao.getPaymentWithdrawal(bukrs, sDate, eDate);
        for (var item in data) {
          selectNameList.add(item['customer']);
        }
        return data;
        break;
      default:
        break;
    }
  }

  _sort(int index, bool ascending, String title, {bool method = false}) {
    setState(() {
      _sortColumnIndex = index;
      _sortAscending = ascending;
      dataList.sort((a, b) {
        if(!ascending) {
          final c = a;
          a = b;
          b = c;
        }
        if(method){
          return a[title].compareTo(b[title]);
        }else {
          return a[title].hashCode.compareTo(b[title].hashCode);
        }

      });
    });
  }

  //输入框查询小部件
  Widget _navWidget(_bodyStr) {
    if(!_isSearch) {
      return Text(_bodyStr);
    }else {
      return  TextField(
        controller: this.controller,
        cursorColor: Colors.white,
        style: TextStyle(color:Colors.white),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
          hintStyle: TextStyle(
              color:Colors.white70,
              fontSize: 14
          ),
          hintText: '请输入客户名相关字段查询',
          prefixIcon: Icon(Icons.search,color: Colors.white70,),
        ),
        onSubmitted: (text) {//内容提交(按回车)的回调
          List itemList=[];
          for(var i = 0; i < selectNameList.length; i++) {
            String itemStr = selectNameList[i];
            if(itemStr.contains(text)) {
              itemList.add(backList[i]);
            }
          }
          if(itemList.length == 0) {
            showDialog(context: context, child: AlertDialog(
              content: new Text( "没有可以匹配的内容",
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('关闭'),
                  onPressed: () => Navigator.pop(context, true),
                )
              ], ));
          }
          setState(() {
            receiveList = itemList;
          });
        },
      ); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _navWidget(_bodyStr),
        actions: <Widget>[
          IconButton(
            icon: Icon(_searchIcon),
            onPressed: () {
              setState(() {
                _isSearch = !_isSearch;
                if (!_isSearch) {
                  _searchIcon = Icons.search;
                  controller.text = '';
                  receiveList = [];
                } else {
                  _searchIcon = Icons.close;
                }
              });
            },
          ),
          PopupMenuButton(
              onSelected: (String value){
                setState(() {
                  _bodyStr = value;
                  if(value == '最近一周') {
                    flag = 1;
                  }else if(value == '最近一月') {
                    flag = 2;
                  }else {
                    flag = 3;
                  }
                  _futureStr = _getPaymentWithdrawal();
                });
              },
              itemBuilder: (BuildContext context) =><PopupMenuItem<String>>[
                PopupMenuItem(
                  value:"最近一周",
                  child: new Text("最近一周"),
                ),
                PopupMenuItem(
                  value: "最近一月",
                  child: new Text("最近一月"),
                ),
                PopupMenuItem(
                  value: "最近三月",
                  child: new Text("最近三月"),
                )
              ]
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _futureStr,
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
              case ConnectionState.done:
                if(snapshot.hasError) {
                  return Container();
                }else if(snapshot.hasData) {
                  dataList = snapshot.data;
                  backList = snapshot.data;
                  if(receiveList.isEmpty) {
                    receiveList = snapshot.data;
                  }
                  return ListView(
                    children: <Widget>[
                      DataTable(
                        columnSpacing: 4,
                        horizontalMargin: 4,
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _sortAscending,
                        columns: [
                          DataColumn(
                              label: Text('客户'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'customer');
                              }
                          ),
                          DataColumn(
                              label: Text('本期回款'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'benqihk', method: true);
                              }
                          ),
                          DataColumn(
                              label: Text('月份'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'month', method: true);
                              }
                          ),
                        ],
                        rows: receiveList.map((data) {
                          return DataRow(
                              cells: [
                                DataCell(
                                  Text('${data['customer']}'),
                                  onTap: () {
                                    String tempDate = data['month'];
                                    var sDate = tempDate.substring(0, 4) + '-' + tempDate.substring(4, 6) + '-01';
                                    var eDate = tempDate.substring(0, 4) + '-' + tempDate.substring(4, 6) + '-31';
                                    NavigatorUtils.goPaymentDetails(context, sDate, eDate, data['cusid']);
                                  },
                                ),
                                DataCell(Text('${data['benqihk']}')),
                                DataCell(Text('${data['month']}')),
                              ]
                          );
                        }).toList(),
                      )
                    ],
                  );
                }else {
                  return Container();
                }
                break;
              default:
                return null;
                break;
            }
          },
        ),
      ),
    );
  }
}


