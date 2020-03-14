import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';

class PaymentDetails extends StatelessWidget {
  final String sDate;
  final String eDate;
  final String kunnr;
  PaymentDetails(this.sDate, this.eDate, this.kunnr);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('回款明细'),
      ),
      body: PaymentDetailsBody(sDate, eDate, kunnr),
    );
  }
}

class PaymentDetailsBody extends StatefulWidget {
  final String sDate;
  final String eDate;
  final String kunnr;
  PaymentDetailsBody(this.sDate, this.eDate, this.kunnr);

  @override
  _PaymentDetailsBodyState createState() => _PaymentDetailsBodyState();
}

class _PaymentDetailsBodyState extends State<PaymentDetailsBody> {

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getPaymentDetails();
  }

  Future _getPaymentDetails() async {
    String bukrs = '1008';
    var sDate = widget.sDate;
    var eDate = widget.eDate;
    var kunnr = widget.kunnr;
    var data = await DataDao.getPaymentDetails(bukrs, sDate, eDate, kunnr);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return PaymentDetailsTable(_futureStr);
  }
}

class PaymentDetailsTable extends StatefulWidget {
  final Future _futureStr;
  PaymentDetailsTable(this._futureStr);

  @override
  _PaymentDetailsTableState createState() => _PaymentDetailsTableState();
}

class _PaymentDetailsTableState extends State<PaymentDetailsTable> {
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
                      horizontalMargin: 6,
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: [
                        DataColumn(
                          label: Text('金额(万)'),
                            onSort: (int index, bool ascending) {
                              _sort(index, ascending, 'je', method: true);
                            }
                        ),
                        DataColumn(
                          label: Text('日期'),
                        ),
                        DataColumn(
                          label: Text('回款方式'),
                        ),
                      ],
                      rows: dataList.map((data) {
                        String temp = data['rq'];
                        return DataRow(
                            cells: [
                              DataCell(Text('${data['je']}'),),
                              DataCell(Text(temp.substring(0, 4) + '-' + temp.substring(4, 6) + '-' + temp.substring(6, 8))),
                              DataCell(Text('${data['hkfs']}')),
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
              return Container();
              break;
          }
        },
      ),
    );
  }
}


