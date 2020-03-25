import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class SaleMessage extends StatefulWidget {
  @override
  _SaleMessageState createState() => _SaleMessageState();
}

class _SaleMessageState extends State<SaleMessage> {
  String _bodyStr = '未开票';
  bool flag = true;

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
    _futureStr = _getNoSaleMessage();
  }

  Future _getNoSaleMessage() async {
    String bukrs = '1008';
    var data;
    selectNameList = [];
    receiveList = [];
    if(selectNameList.isNotEmpty) {
      selectNameList.clear();
    }
    if(flag) {
      data = await DataDao.getNoSaleMessage(bukrs);
    }else {
      data = await DataDao.getSaleMessage(bukrs);
    }

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
                  if(value == '未开票') {
                    flag = true;
                  }else {
                    flag = false;
                  }
                  _futureStr = _getNoSaleMessage();
                });
              },
              itemBuilder: (BuildContext context) =><PopupMenuItem<String>>[
                PopupMenuItem(
                  value:"未开票",
                  child: Text("未开票"),
                ),
                PopupMenuItem(
                  value: "已开票",
                  child: Text("已开票"),
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
                      flag ? DataTable(
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
                              label: Text('金额'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'money', method: true);
                              }
                          ),
                        ],
                        rows: receiveList.map((data) {
                          return DataRow(
                              cells: [
                                DataCell(
                                  Text('${data['customer']}'),
                                  onTap: () {
                                    NavigatorUtils.goNoSaleDetails(context, kunnr: data['cusid'], fhmonth: data['month']);
                                  },
                                ),
                                DataCell(Text('${data['money']}')),
                              ]
                          );
                        }).toList(),
                      )
                          : DataTable(
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
                              label: Text('数量'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'num', method: true);
                              }
                          ),
                          DataColumn(
                              label: Text('金额'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'money');
                              }
                          ),
                          DataColumn(
                              label: Text('开票日期'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'date', method: true);
                              }
                          ),
                          DataColumn(
                              label: Text('金税票号'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'ticketnum');
                              }
                          ),
                        ],
                        rows: receiveList.map((data) {
                          return DataRow(
                              cells: [
                                DataCell(
                                  Text('${data['customer']}'),
                                  onTap: () {
                                    NavigatorUtils.goSaleDetails(context, ticketnum: data['numid']);
                                  },
                                ),
                                DataCell(Text('${data['num']}')),
                                DataCell(Text('${data['money']}')),
                                DataCell(Text('${data['date']}')),
                                DataCell(Text('${data['ticketnum']}')),
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


