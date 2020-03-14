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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_bodyStr),
        actions: <Widget>[
          new PopupMenuButton(
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
      body: SaleMessageBody(flag),
    );
  }
}

class SaleMessageBody extends StatefulWidget {

  final int flag;
  SaleMessageBody(this.flag);

  @override
  _SaleMessageBodyState createState() => _SaleMessageBodyState();
}

class _SaleMessageBodyState extends State<SaleMessageBody> {

  Future _futureStr;
  Future _futureStr2;
  Future _futureStr3;

  @override
  void initState() {
    super.initState();
    // TODO: 需要优化
    var today = DateTime.now();
    var weekAgoDate = today.add(Duration(days: -7));
    var monthAgoDate = today.add(Duration(days: -30));
    var thirtyAgoDate = today.add(Duration(days: -90));
    String s_date = formatDate(weekAgoDate, [yyyy, '-', mm, '-', dd]);
    String e_date = formatDate(today, [yyyy, '-', mm, '-', dd]);
    _futureStr = _getPaymentWithdrawal(s_date, e_date);
    s_date = formatDate(monthAgoDate, [yyyy, '-', mm, '-', dd]);
    _futureStr2 = _getPaymentWithdrawal(s_date, e_date);
    s_date = formatDate(thirtyAgoDate, [yyyy, '-', mm, '-', dd]);
    _futureStr3 = _getPaymentWithdrawal(s_date, e_date);
  }


  @override
  void didUpdateWidget(SaleMessageBody oldWidget) {
    super.didUpdateWidget(oldWidget);

    switch(widget.flag) {
      case 1:
        _futureStr = _futureStr;
        break;
      case 2:
        _futureStr = _futureStr2;
        break;
      case 3:
        _futureStr = _futureStr3;
        break;
      default:
        break;
    }
  }



  Future _getPaymentWithdrawal(sDate, eDate) async {
    String bukrs = '1008';
    var data = await DataDao.getPaymentWithdrawal(bukrs, sDate, eDate);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return NoSaleMessageHomeTable(_futureStr);
  }
}

class NoSaleMessageHomeTable extends StatefulWidget {
  final Future _futureStr;
  NoSaleMessageHomeTable(this._futureStr);

  @override
  _NoSaleMessageHomeTableState createState() => _NoSaleMessageHomeTableState();
}

class _NoSaleMessageHomeTableState extends State<NoSaleMessageHomeTable> {
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
                      rows: dataList.map((data) {
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
    );
  }
}


