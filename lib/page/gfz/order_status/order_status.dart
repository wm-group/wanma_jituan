import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class OrderStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单状态'),
      ),
      body: OrderStatusBody(),
    );
  }
}

class OrderStatusBody extends StatefulWidget {
  @override
  _OrderStatusBodyState createState() => _OrderStatusBodyState();
}

class _OrderStatusBodyState extends State<OrderStatusBody> {

  Future _futureStr;

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
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return OrderStatusHomeTable(_futureStr);
  }
}

class OrderStatusHomeTable extends StatefulWidget {
  final Future _futureStr;
  OrderStatusHomeTable(this._futureStr);

  @override
  _OrderStatusHomeTableState createState() => _OrderStatusHomeTableState();
}

class _OrderStatusHomeTableState extends State<OrderStatusHomeTable> {
  List dataList;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
            future: widget._futureStr,
            builder: (context, snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
                case ConnectionState.done:
                  if(snapshot.hasError) {
                    return Container();
                  }else if(snapshot.hasData) {
                    dataList = snapshot.data;
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
                          rows: dataList.map((data) {
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
    );
  }
}


