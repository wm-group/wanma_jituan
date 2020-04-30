import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/event/submit_event.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
import 'package:wanma_jituan/common/net/code.dart';
import 'package:wanma_jituan/common/utils/common_utils.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeliverRequire extends StatefulWidget {
  final String vbeln;
  DeliverRequire(this.vbeln);

  @override
  _DeliverRequireState createState() => _DeliverRequireState();
}

class _DeliverRequireState extends State<DeliverRequire> {
  List _data;
  StreamSubscription _subscription;

  @override
  void initState() {
    // TODO: implement initState
    _subscription = Code.eventBus.on<SubmitEvent>().listen((event) {
      _data = event.data;
    });
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription.cancel();
  }

  Future _deliverEditSave(action, dataList) async {
    String userName = await LocalStorage.get(Config.USER_NAME_KEY);
    var data = await DataDao.deliverEditSave(userName, action, dataList);
    return data;
  }

  _deliverSubmit(context) {
    if(_data != null) {
      List tempList = List();
      for(var temp in _data) {
        if(temp['selected'] == true) {
          if(temp['STATS'] == '确认' || temp['STATS'] == '删除') {
            Fluttertoast.showToast(msg: '状态为确认或者删除，不能提交');
            tempList = null;
            break;
          }
          Map tempMap = Map();
          tempMap['QIMG'] = temp['QIMG'];
          tempMap['VDATU'] = temp['VDATU'];
          tempMap['VBELN'] = temp['VBELN'];
          tempMap['POSNR'] = temp['POSNR'];
          tempList.add(tempMap);
        }
      }
      if(tempList != null) {
        _deliverEditSave('03', tempList).then((value) {
          if(value['status'] == 'OK') {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('提示'),
                    content: Text('提交成功！'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          NavigatorUtils.goDeliverDetails(context, widget.vbeln);
                        },
                        child: Text('确定'),
                      ),
                    ],
                  );
                }
            );
          }else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('提示'),
                    content: Text('提交失败!' + value['errordesc']),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('确定'),
                      ),
                    ],
                  );
                }
            );
          }
        });
      }
    }else {
      Fluttertoast.showToast(msg: '请先勾选再提交');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  //TODO 跳转到发货需求编辑页面
                  NavigatorUtils.goDeliverEdit(context, widget.vbeln);
                },
                child: CommonUtils.whiteText('发货需求'),
            ),
            FlatButton(
                onPressed: () {
                  _deliverSubmit(context);
                },
                child: CommonUtils.whiteText('提交'),
            )
          ],
        ),
        body: DeliverRequireBody(widget.vbeln)
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

  @override
  void didUpdateWidget(DeliverRequireBody oldWidget) {
    super.didUpdateWidget(oldWidget);
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
                for(var temp in dataList) {
                  temp['selected'] == null ? temp['selected'] = false : temp['selected'] = temp['selected'];
                }
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
                        Code.eventBus.fire(SubmitEvent(dataList));
                        setState(() {
                        });
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
                          selected: data['selected'] ?? false,
                          onSelectChanged: (value) {
                            setState(() {
                              if(data['selected'] != value) {
                                data['selected'] = value;
                              }
                              Code.eventBus.fire(SubmitEvent(dataList));
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


