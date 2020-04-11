import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';

class SaleDetails extends StatelessWidget {

  final String kunnr;
  final String fhmonth;
  final String ticketnum;

  SaleDetails({this.kunnr, this.fhmonth, this.ticketnum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ticketnum == null ? Text('未开票明细') : Text('已开票明细'),
      ),
      body: ticketnum == null ? SaleDetailsBody(kunnr: kunnr, fhmonth: fhmonth) : SaleDetailsBody(ticketnum: ticketnum),
    );
  }
}

class SaleDetailsBody extends StatefulWidget {

  final String kunnr;
  final String fhmonth;
  final String ticketnum;

  SaleDetailsBody({this.kunnr, this.fhmonth, this.ticketnum});

  @override
  _SaleDetailsBodyState createState() => _SaleDetailsBodyState();
}

class _SaleDetailsBodyState extends State<SaleDetailsBody> {

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.ticketnum == null) {
      _futureStr = _getNoSaleDetails();
    }else {
      _futureStr = _getSaleDetails();
    }

  }

  Future _getNoSaleDetails() async {
    String bukrs = '1008';
    String kunnr = widget.kunnr;
    String fhmonth = widget.fhmonth;
    var data = await DataDao.getNoSaleDetails(bukrs, kunnr, fhmonth);
    return data;
  }

  Future _getSaleDetails() async {
    String bukrs = '1008';
    String ticketnum = widget.ticketnum;
    var data = await DataDao.getSaleDetails(bukrs, ticketnum);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SaleDetailsHomeTable(_futureStr);
  }
}

class SaleDetailsHomeTable extends StatefulWidget {
  final Future _futureStr;
  SaleDetailsHomeTable(this._futureStr);

  @override
  _SaleDetailsHomeTableState createState() => _SaleDetailsHomeTableState();
}

class _SaleDetailsHomeTableState extends State<SaleDetailsHomeTable> {
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
                            label: Text('发货日期'),
                            onSort: (int index, bool ascending) {
                              _sort(index, ascending, 'date', method: true);
                            }
                        ),
                        DataColumn(
                            label: Text('物料描述'),
                            onSort: (int index, bool ascending) {
                              _sort(index, ascending, 'describe');
                            }
                        ),
                        DataColumn(
                            label: Text('数量'),
                        ),
                        DataColumn(
                            label: Text('单价'),
                        ),
                        DataColumn(
                            label: Text('金额'),
                        ),
                      ],
                      rows: dataList.map((data) {
                        return DataRow(
                            cells: [
                              DataCell(Text('${data['date']}'),),
                              DataCell(
                                  Container(
                                    width: MediaQuery.of(context).size.width/4,
                                    child: Text('${data['describe']}', softWrap: true,),
                                  ),
                              ),
                              DataCell(Text('${data['num']}')),
                              DataCell(Text('${data['perprice']}')),
                              DataCell(Text('${data['money']}')),
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


