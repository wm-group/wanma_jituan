import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/widget/customer_appbar.dart';

class DeliveryTracking extends StatefulWidget {
  @override
  _DeliveryTrackingState createState() => _DeliveryTrackingState();
}

class _DeliveryTrackingState extends State<DeliveryTracking> {

  Future _futureStr;

  List dataList;
  int _sortColumnIndex;
  bool _sortAscending = true;
  DeliveryTrackingDataSource _dataSource;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

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
    _futureStr = _getDeliveryTracking();
  }

  Future _getDeliveryTracking() async {
    String bukrs = '1008';
    var data = await DataDao.getDeliveryTracking(bukrs);
    selectNameList = [];
    receiveList = [];
    for (var item in data) {
      selectNameList.add(item['kh']);
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
      return Text('发货跟踪');
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
            icon: Icon(Icons.search),
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
                  _dataSource = DeliveryTrackingDataSource(receiveList);
//                  dataList = JsonDecoder().convert(JsonString.tempData);
                  return ListView(
                    children: <Widget>[
                      PaginatedDataTable(
                        header: Text('发货跟踪表'),
                        rowsPerPage: _rowsPerPage,
                        onRowsPerPageChanged: (int value) { setState(() { _rowsPerPage = value; }); },
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _sortAscending,
                        columns: <DataColumn>[
                          DataColumn(
                              label: Text('客户'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'kh');
                              }
                          ),
                          DataColumn(
                            label: Text('产品'),
                          ),
                          DataColumn(
                              label: Text('数量'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'sl', method: true);
                              }
                          ),
                          DataColumn(
                              label: Text('要求发货日期'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'pdrq', method: true);
                              }
                          ),
                          DataColumn(
                              label: Text('仓库操作时间'),
                              onSort: (int index, bool ascending) {
                                _sort(index, ascending, 'fhrq', method: true);
                              }
                          ),
                        ],
                        source: _dataSource,
                      )
//                    DataTable(
//                      columnSpacing: 4,
//                      horizontalMargin: 4,
//                      sortColumnIndex: _sortColumnIndex,
//                      sortAscending: _sortAscending,
//                      columns: [
//                        DataColumn(
//                            label: Text('客户'),
//                            onSort: (int index, bool ascending) {
//                              _sort(index, ascending, 'kh');
//                            }
//                        ),
//                        DataColumn(
//                            label: Text('产品'),
//                        ),
//                        DataColumn(
//                            label: Text('数量'),
//                            onSort: (int index, bool ascending) {
//                              _sort(index, ascending, 'sl', method: true);
//                            }
//                        ),
//                        DataColumn(
//                            label: Text('要求发货日期'),
//                            onSort: (int index, bool ascending) {
//                              _sort(index, ascending, 'pdrq', method: true);
//                            }
//                        ),
//                        DataColumn(
//                            label: Text('仓库操作时间'),
//                            onSort: (int index, bool ascending) {
//                              _sort(index, ascending, 'fhrq', method: true);
//                            }
//                        ),
//                      ],
//                      rows: dataList.map((data) {
//                        return DataRow(
//                            cells: [
//                              DataCell(Text('${data['kh']}')),
//                              DataCell(Text('${data['cp']}')),
//                              DataCell(Text('${data['sl']}')),
//                              DataCell(Text('${data['pdrq']}')),
//                              DataCell(Text('${data['fhrq']}')),
//                            ]
//                        );
//                      }).toList(),
//                    )
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

class DeliveryTrackingDataSource extends DataTableSource {

  final List _dataList;
  DeliveryTrackingDataSource(this._dataList);

  @override
  DataRow getRow(int index) {
    if (index >= _dataList.length)
      return null;
    final Map temp = _dataList[index];
    return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          DataCell(Text('${temp['kh']}')),
          DataCell(Text('${temp['cp']}')),
          DataCell(Text('${temp['sl']}')),
          DataCell(Text('${temp['pdrq']}')),
          DataCell(Text('${temp['fhrq']}')),
        ]);
  }

  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _dataList.length;
}


