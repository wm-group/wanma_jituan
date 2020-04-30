import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/common_utils.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class OrderDetails extends StatelessWidget {

  final String cusId;
  OrderDetails({this.cusId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('订单明细'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  //TODO 跳转到发货需求页面
                  NavigatorUtils.goDeliverRequire(context, cusId);
                },
                child: CommonUtils.whiteText('发货需求'),
            ),
          ],
        ),
        body: OrderDetailsBody(cusId)
    );
  }
}

class CusIdContainer extends InheritedWidget {
  static CusIdContainer of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CusIdContainer) as CusIdContainer;

  final String cusId;
  CusIdContainer({
    Key key,
    @required this.cusId,
    @required Widget child
  }): super(key: key, child: child);

  @override
  bool updateShouldNotify(CusIdContainer oldWidget) {
    // TODO: implement updateShouldNotify
    return cusId != oldWidget.cusId;
  }
}

class OrderDetailsBody extends StatefulWidget {
  final String cusId;
  OrderDetailsBody(this.cusId);

  @override
  _OrderDetailsBodyState createState() => _OrderDetailsBodyState();
}

class _OrderDetailsBodyState extends State<OrderDetailsBody> {

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getOrderDetailsData();
  }

  Future _getOrderDetailsData() async {
    String bukrs = '1008';
    var vbeln = widget.cusId;
    var data = await DataDao.getOrderDetailsData(bukrs, vbeln);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return CusIdContainer(cusId: widget.cusId, child: OrderDetailsTable(_futureStr));
  }
}

class OrderDetailsTable extends StatefulWidget {
  final Future _futureStr;
  OrderDetailsTable(this._futureStr);

  @override
  _OrderDetailsTableState createState() => _OrderDetailsTableState();
}

class _OrderDetailsTableState extends State<OrderDetailsTable> {
  List dataList;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _sort(int index, bool ascending, String title) {
    setState(() {
      _sortColumnIndex = index;
      _sortAscending = ascending;
      dataList.sort((a, b) {
        if(!ascending) {
          final c = a;
          a = b;
          b = c;
        }
        return a[title].hashCode.compareTo(b[title].hashCode);
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
                            onSort: (int index, bool ascending) {
                              _sort(index, ascending, 'wuliao');
                            }
                        ),
                        DataColumn(
                          label: Text('数量'),
                        ),
                        DataColumn(
                          label: Text('发出量'),
                        ),
                        DataColumn(
                          label: Text('单价'),
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
                                Container(
                                  width: MediaQuery.of(context).size.width/4,
                                  child: Text('${data['wuliao']}', softWrap: true,),
                                ),
                                onTap: () {
                                  CusIdContainer state = CusIdContainer.of(context);
                                  var vbeln = state.cusId;
                                  var posnr = data['posnr'];
                                  NavigatorUtils.goOrderGoodsFollow(context, vbeln, posnr);
                                },
                              ),
                              DataCell(Text('${data['num']}')),
                              DataCell(Text('${data['outnum']}')),
                              DataCell(Text('${data['price']}')),
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


