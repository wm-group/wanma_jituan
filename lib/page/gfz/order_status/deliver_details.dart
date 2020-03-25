import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class DeliverDetails extends StatelessWidget {
  final String cusId;
  DeliverDetails(this.cusId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发货需求明细页'),
      ),
      body: DeliverDetailsBody(cusId),
    );
  }
}

class DeliverDetailsBody extends StatefulWidget {
  final String cusId;
  DeliverDetailsBody(this.cusId);

  @override
  _DeliverDetailsBodyState createState() => _DeliverDetailsBodyState();
}

class _DeliverDetailsBodyState extends State<DeliverDetailsBody> {

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getDeliverRequireData();
  }

  Future _getDeliverRequireData() async {
    var vbeln = widget.cusId;
    var data = await DataDao.getDeliverRequireData(vbeln);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return DeliverDetailsTable(_futureStr);
  }
}

class DeliverDetailsTable extends StatefulWidget {
  final Future _futureStr;
  DeliverDetailsTable(this._futureStr);

  @override
  _DeliverDetailsTableState createState() => _DeliverDetailsTableState();
}

class _DeliverDetailsTableState extends State<DeliverDetailsTable> {
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
                            label: Text('物料'),
                        ),
                        DataColumn(
                            label: Text('订单量'),
                        ),
                        DataColumn(
                            label: Text('发出量'),
                        ),
                        DataColumn(
                            label: Text('申请量'),
                        ),
                        DataColumn(
                            label: Text('申请交期'),
                        ),
                        DataColumn(
                            label: Text('状态'),
                        ),
                      ],
                      rows: dataList.map((data) {
                        return DataRow(
                            cells: [
                              DataCell(Text('${data['markt']}'),),
                              DataCell(Text('${data['kwmeng']}')),
                              DataCell(Text('${data['lgmng']}')),
                              DataCell(Text('${data['qimg']}')),
                              DataCell(Text('${data['vdatu']}')),
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


