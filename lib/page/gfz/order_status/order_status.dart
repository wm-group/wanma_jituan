import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class OrderStatus extends StatefulWidget {
  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {

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
    // TODO: implement initState
    super.initState();
    _futureStr = _getOrderData();
  }

  Future _getOrderData() async {
    String bukrs = '1008';
    var today = DateTime.now();
    var monthAgoDate = today.add(Duration(days: -30));
    String s_date = formatDate(monthAgoDate, [yyyy, '-', mm, '-', dd]);
    String e_date = formatDate(today, [yyyy, '-', mm, '-', dd]);
    var data = await DataDao.getOrderData(bukrs, s_date, e_date);
    selectNameList = [];
    receiveList = [];
    for (var item in data) {
      selectNameList.add(item['customer']);
    }
    return data;
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
  Widget _navWidget() {
    if(!_isSearch) {
      return Text('订单状态');
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
        title: _navWidget(),
        centerTitle: true,
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
//                  dataList = JsonDecoder().convert(JsonString.tempData);
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
                              label: Text('下单日期'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'orderdate', method: true);
                              }
                          ),
                          DataColumn(
                              label: Text('交货日期'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'handdate', method: true);
                              }
                          ),
                          DataColumn(
                              label: Text('状态'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'status');
                              }
                          ),
                        ],
                        rows: receiveList.map((data) {
                          return DataRow(
                              cells: [
                                DataCell(
                                  Text('${data['customer']}'),
                                  onTap: () {
//                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text(data['customer'])));
                                    NavigatorUtils.goOrderDetails(context, data['vbeln']);
                                  },
                                ),
                                DataCell(Text('${data['orderdate']}')),
                                DataCell(Text('${data['handdate']}')),
                                DataCell(Text('${data['status']}')),
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