import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';

class OrderGoodsFollow extends StatelessWidget {
  final String vbeln;
  final String posnr;
  OrderGoodsFollow(this.vbeln, this.posnr);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单物流跟踪明细'),
      ),
      body: OrderGoodsBody(vbeln, posnr),
    );
  }
}

class OrderGoodsBody extends StatefulWidget {
  final String vbeln;
  final String posnr;
  OrderGoodsBody(this.vbeln, this.posnr);

  @override
  _OrderGoodsBodyState createState() => _OrderGoodsBodyState();
}

class _OrderGoodsBodyState extends State<OrderGoodsBody> {

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getOrderGoodsData();
  }

  Future _getOrderGoodsData() async {
    String bukrs = '1008';
    var vbeln = widget.vbeln;
    var posnr = widget.posnr;
    var data = await DataDao.getOrderGoodsData(bukrs, vbeln, posnr);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return OrderGoodsTable(_futureStr);
  }
}

class OrderGoodsTable extends StatefulWidget {
  final Future _futureStr;
  OrderGoodsTable(this._futureStr);

  @override
  _OrderGoodsTableState createState() => _OrderGoodsTableState();
}

class _OrderGoodsTableState extends State<OrderGoodsTable> {
  List dataList;

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
                        columnSpacing: 8,
                        columns: [
                          DataColumn(
                            label: Text('物流公司'),
                          ),
                          DataColumn(
                            label: Text('发货日期'),
                          ),
                          DataColumn(
                            label: Text('司机电话'),
                          ),
                          DataColumn(
                            label: Text('发出数量'),
                          ),
                        ],
                        rows: dataList.map((data) {
                          return DataRow(
                              cells: [
                                DataCell(Text('${data['campany']}'),),
                                DataCell(Text('${data['outdate']}')),
                                DataCell(Text('${data['phone']}')),
                                DataCell(Text('${data['lgmng']}')),
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


