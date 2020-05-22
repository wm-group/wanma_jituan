import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/ty_dao.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';

class TYInventoryMessage extends StatelessWidget {

  final String sk;
  final String result;
  TYInventoryMessage(this.sk, this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('半成品盘点'),
      ),
      body: InventoryMessageBody(sk, result),
    );
  }
}

class InventoryMessageBody extends StatefulWidget {

  final String sk;
  final String result;
  InventoryMessageBody(this.sk, this.result);

  @override
  _InventoryMessageBodyState createState() => _InventoryMessageBodyState();
}

class _InventoryMessageBodyState extends State<InventoryMessageBody> {

  Future _futureStr;
  var recId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getTYInventoryMessage();
  }

  _getTYInventoryMessage() async {
    var data = await TYDao.getTYInventoryMessage(widget.sk, widget.result);
    return data;
  }

  _getTYInventorySure(sk, barcode, recId) async {
    var data = await TYDao.getTYInventorySure(sk, barcode, recId);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('提示信息'),
          content: Text('${data['message']}'),
          actions: <Widget>[
            FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('确认')),
          ],
        );
      }
    );
  }

  _getRowData(title, value) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(title, style: WMConstant.normalText, textAlign: TextAlign.center,), flex: 1,),
        Expanded(child: Text('$value', style: WMConstant.normalText, textAlign: TextAlign.center,), flex: 1,)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _futureStr,
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
            case ConnectionState.done:
              if(snapshot.hasError) {
                return Container();
              }else if(snapshot.hasData) {
                var dataMap = snapshot.data;
                if(dataMap == null) {
                  return Container();
                }else {
                  if(dataMap['status'] == 'ok') {
                    recId = dataMap['recipe_id'];
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          _getRowData('订单号', dataMap['bstkd']),
                          Padding(padding: EdgeInsets.all(10)),
                          _getRowData('品名', dataMap['part_name']),
                          Padding(padding: EdgeInsets.all(10)),
                          _getRowData('随工单号', dataMap['barcode']),
                          Padding(padding: EdgeInsets.all(10)),
                          _getRowData('数量', dataMap['qty']),
                          Padding(padding: EdgeInsets.all(10)),
                          _getRowData('工段', dataMap['recipe_title']),
                          Padding(padding: EdgeInsets.all(10)),
                          _getRowData('盘号', dataMap['carrier_id']),
                          Padding(padding: EdgeInsets.all(10)),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('返回', style: WMConstant.normalTextWhite,),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(20)),
                              Expanded(
                                flex: 1,
                                child: RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    _getTYInventorySure(widget.sk, widget.result, recId);
                                  },
                                  child: Text('确认', style: WMConstant.normalTextWhite,),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                        ],
                      ),
                    );
                  }else {
//                    return Container(child: Center(child: Text('${dataMap['message']}'),),);
                    Future.delayed(Duration(milliseconds: 100), () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('提示'),
                              content: Text('${dataMap['message']}'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('确定'),
                                )
                              ],
                            );
                          }
                      );
                    });
                  }
                  return Container();
                }
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

