import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/event/submit_event.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
import 'package:wanma_jituan/common/net/code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class DeliverEdit extends StatefulWidget {

  final String vbeln;
  DeliverEdit(this.vbeln);

  @override
  _DeliverEditState createState() => _DeliverEditState();
}

class _DeliverEditState extends State<DeliverEdit> {

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

  //
  Future _deliverEditSave(action, dataList) async {
    String userName = await LocalStorage.get(Config.USER_NAME_KEY);
    var data = await DataDao.deliverEditSave(userName, action, dataList);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  List tempList = List();
                  for(var temp in _data) {
                    if(temp['selected'] == true) {
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
                  }else {
                    Fluttertoast.showToast(msg: '请先勾选再提交');
                  }

                },
                child: Text('保存并提交')
            ),
            FlatButton(
                onPressed: () {
                  List tempList = List();
                  for(var temp in _data) {
                    if(temp['selected'] == true) {
                      Map tempMap = Map();
                      tempMap['QIMG'] = temp['QIMG'];
                      tempMap['VDATU'] = temp['VDATU'];
                      tempMap['VBELN'] = temp['VBELN'];
                      tempMap['POSNR'] = temp['POSNR'];
                      tempList.add(tempMap);
                    }
                  }
                  if(tempList != null) {
                    _deliverEditSave('01', tempList).then((value) {
                      if(value['status'] == 'OK') {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('提示'),
                                content: Text('保存成功！'),
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
                      }else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('提示'),
                                content: Text('保存失败!' + value['errordesc']),
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
                  }else {
                    Fluttertoast.showToast(msg: '请先勾选再保存');
                  }
                },
                child: Text('保存')
            )
          ],
        ),
        body: DeliverEditBody(widget.vbeln)
    );
  }
}

class DeliverEditBody extends StatefulWidget {
  final String vbeln;
  DeliverEditBody(this.vbeln);

  @override
  _DeliverEditBodyState createState() => _DeliverEditBodyState();
}

class _DeliverEditBodyState extends State<DeliverEditBody> {

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getDeliverEditData();

  }

  Future _getDeliverEditData() async {
    var vbeln = widget.vbeln;
    var data = await DataDao.getDeliverEditData(vbeln);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return DeliverEditTable(_futureStr);
  }
}

class DeliverEditTable extends StatefulWidget {
  final Future _futureStr;
  DeliverEditTable(this._futureStr);

  @override
  _DeliverEditTableState createState() => _DeliverEditTableState();
}

class _DeliverEditTableState extends State<DeliverEditTable> {
  List dataList;
  int _sortColumnIndex;
  bool _sortAscending = true;

  final TextEditingController _textController = TextEditingController();

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
                  scrollDirection: Axis.horizontal,
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
                          label: Text('已申请量'),
                        ),
                        DataColumn(
                          label: Text('可申请量'),
                        ),
                        DataColumn(
                          label: Text('申请交期'),
                        ),
                      ],
                      rows: dataList.map((data) {
                        _textController.value = TextEditingValue(text: data['QIMG']);
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
                                Text('${data['MAKTX']}'),
                              ),
                              DataCell(Text('${data['KWMENG']}')),
                              DataCell(Text('${data['LGMNG']}')),
                              DataCell(Text('${data['QIMG_APPLY']}')),
                              DataCell(
                                TextField(
                                  controller: _textController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    //得到修改值
                                    data['QIMG'] = value;
                                  },
                                  onTap: () {
                                    if(data['selected']) {
                                      showDialog(context: context, builder: (context) {
                                        return AlertDialog(
                                          title: Text('提示'),
                                          content: Text('请取消勾选后再编辑'),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('确认'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    }else {
                                    }
                                  },
                                ),
                                showEditIcon: true,
                              ),
                              DataCell(
                                Text('${data['VDATU']}'),
                                onTap: () {
                                  if(data['selected']) {
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        title: Text('提示'),
                                        content: Text('请取消勾选后再编辑'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('确认'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                  }else {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.parse(data['VDATU']),
                                      firstDate: DateTime(2018),
                                      lastDate: DateTime(2030),
                                      builder: (BuildContext context, Widget child) {
                                        return Theme(
                                          data: ThemeData.dark(),
                                          child: child,
                                        );
                                      },
                                    ).then((date){
                                      setState(() {
                                        if(date != null){
                                          data['VDATU'] = formatDate(date, [yyyy, '-', mm, '-', dd]);
                                        }
                                      });
                                    });
                                  }
                                },
                              ),
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


