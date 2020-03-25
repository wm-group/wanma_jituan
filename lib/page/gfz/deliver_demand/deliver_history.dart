import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class DeliverHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('历史发货需求'),
      ),
      body: DeliverHistoryBody(),
    );
  }
}

class DeliverHistoryBody extends StatefulWidget {
  @override
  _DeliverHistoryBodyState createState() => _DeliverHistoryBodyState();
}

class _DeliverHistoryBodyState extends State<DeliverHistoryBody> {

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getDeliverHistoryData();
  }

  Future _getDeliverHistoryData() async {
    var data = await DataDao.getDeliverHistoryData();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return DeliverHistoryHomeTable(_futureStr);
  }
}

class DeliverHistoryHomeTable extends StatefulWidget {
  final Future _futureStr;
  DeliverHistoryHomeTable(this._futureStr);

  @override
  _DeliverHistoryHomeTableState createState() => _DeliverHistoryHomeTableState();
}

class _DeliverHistoryHomeTableState extends State<DeliverHistoryHomeTable> {
  List dataList;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    DataTable(
                      columnSpacing: 4,
                      horizontalMargin: 4,
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: [
                        DataColumn(label: Text('客户'),),
                        DataColumn(label: Text('物料'),),
                        DataColumn(label: Text('申请交期'),),
                        DataColumn(label: Text('申请数量'),),
                        DataColumn(label: Text('反馈交期'),),
                        DataColumn(label: Text('反馈数量'),),
                        DataColumn(label: Text('反馈说明'),),
                      ],
                      rows: dataList.map((data) {
                        return DataRow(
                            cells: [
                              DataCell(Text('${data['sortl']}'),),
                              DataCell(Text('${data['marktx']}')),
                              DataCell(Text('${data['vdatu']}')),
                              DataCell(Text('${data['qimg']}')),
                              DataCell(Text('${data['pdate']}')),
                              DataCell(Text('${data['pfkimg']}')),
                              DataCell(Text('${data['shuoMing']}')),
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


