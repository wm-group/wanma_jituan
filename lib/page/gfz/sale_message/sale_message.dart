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
                  if(value == '未开票') {
                    flag = true;
                  }else {
                    flag = false;
                  }
                });
              },
              itemBuilder: (BuildContext context) =><PopupMenuItem<String>>[
                PopupMenuItem(
                  value:"未开票",
                  child: new Text("未开票"),
                ),
                PopupMenuItem(
                  value: "已开票",
                  child: new Text("已开票"),
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

  final bool flag;
  SaleMessageBody(this.flag);

  @override
  _SaleMessageBodyState createState() => _SaleMessageBodyState();
}

class _SaleMessageBodyState extends State<SaleMessageBody> {

  Future _futureStr;
  Future _futureStr2;

  @override
  void initState() {
    super.initState();
    // TODO: 需要优化
    _futureStr = _getNoSaleMessage();
    _futureStr2 = _getSaleMessage();
  }

  @override
  void didUpdateWidget(SaleMessageBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    _futureStr = widget.flag ? _futureStr : _futureStr2;
  }



  Future _getNoSaleMessage() async {
    String bukrs = '1008';
    var data = await DataDao.getNoSaleMessage(bukrs);
    return data;
  }

  Future _getSaleMessage() async {
    String bukrs = '1008';
    var data = await DataDao.getSaleMessage(bukrs);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return NoSaleMessageHomeTable(_futureStr, widget.flag);
  }
}

class NoSaleMessageHomeTable extends StatefulWidget {
  final Future _futureStr;
  final bool flag;
  NoSaleMessageHomeTable(this._futureStr, this.flag);

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
                    widget.flag ? DataTable(
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
                      rows: dataList.map((data) {
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
                      rows: dataList.map((data) {
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
    );
  }
}


