import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class DeliverRequire extends StatelessWidget {

  final String vbeln;
  DeliverRequire(this.vbeln);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  //TODO 跳转到发货需求编辑页面
                  NavigatorUtils.goDeliverEdit(context, vbeln);
                },
                child: Text('发货需求')
            ),
            FlatButton(
                onPressed: () {
                  //TODO 提交功能
                },
                child: Text('提交')
            )
          ],
        ),
        body: DeliverRequireBody(vbeln)
    );
  }
}

class CusIdContainer extends InheritedWidget {
  static CusIdContainer of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CusIdContainer) as CusIdContainer;

  final String vbeln;
  CusIdContainer({
    Key key,
    @required this.vbeln,
    @required Widget child
  }): super(key: key, child: child);

  @override
  bool updateShouldNotify(CusIdContainer oldWidget) {
    // TODO: implement updateShouldNotify
    return vbeln != oldWidget.vbeln;
  }
}

class DeliverRequireBody extends StatefulWidget {
  final String vbeln;
  DeliverRequireBody(this.vbeln);

  @override
  _DeliverRequireBodyState createState() => _DeliverRequireBodyState();
}

class _DeliverRequireBodyState extends State<DeliverRequireBody> {

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getDeliverRequireData();

  }

  Future _getDeliverRequireData() async {
    var vbeln = widget.vbeln;
    var data = await DataDao.getDeliverRequireData(vbeln);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return DeliverRequireTable(_futureStr);
  }
}

class DeliverRequireTable extends StatefulWidget {
  final Future _futureStr;
  DeliverRequireTable(this._futureStr);

  @override
  _DeliverRequireTableState createState() => _DeliverRequireTableState();
}

class _DeliverRequireTableState extends State<DeliverRequireTable> {
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
                  children: <Widget>[
                    DataTable(
                      columnSpacing: 4,
                      horizontalMargin: 4,
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      onSelectAll: (value) {
                        for(var temp in dataList) {
                          temp['selected'] = value;
                        }
                      },
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
                          selected: data['selected'],
                          onSelectChanged: (value) {
                            setState(() {
                              if(data['selected'] != value) {
                                data['selected'] = value;
                              }
                            });
                          },
                            cells: [
                              DataCell(
                                Text('${data['markt']}'),
                              ),
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


