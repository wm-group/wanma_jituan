import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';
import 'package:flutter/services.dart';

class StorageForm extends StatefulWidget {

  final String wareId;
  final String wareName;
  final String sk;
  final String inoutId;
  final String purpose;

  StorageForm(this.wareId, this.wareName, this.sk, this.inoutId, this.purpose);

  @override
  _StorageFormState createState() => _StorageFormState();
}

class _StorageFormState extends State<StorageForm> {

  var detailData;
  List carData;
  List expData;
  List wareData;
  List partPacksData;

  Future _futureStr;

  List<DropdownMenuItem> wareItems = List();
  var wareValue;

  List packsValues;
  List unitValues;

  //下拉赋值flag
  bool _firstFlag = true;
  bool _packsFirstFlag = true;
  bool _unitFirstFlag = true;
  bool _detachFlag = true;

  //第一次赋值
  bool _firstCreate = true;

  bool _expOnTapFlag = true;
  List<bool> _expOnTap;

  List _wareList;

  Map _numMap = Map();
  Map _batchMap = Map();
  Map _packsMap = Map();
  Map _unitMap = Map();

  List _loadIdList;
  List _numList;
  List _batchList;

  List resultFlag;//入库成功与否

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getWareDetail();
  }

  _getWareDetail() async {
    var data = await DataDao.getWareDetail(
        widget.sk, widget.wareId, widget.inoutId, widget.purpose);
    return data;

//    carData = detailData[0]['carLoadings'];
//    expData = detailData[0]['rtCarCauses'];
//    wareData = detailData[0]['ctWmWares'];
//    partPacksData = detailData[0]['ctWmPartPacks'];
  }

  var titleList = ['采购订单号','供应商批次','物料名称','计划数量','实际数量',
    '生产日期','拆分','包装明细','散/托'];

  List<TextEditingController> _batchControllers;

  List<TextEditingController> _actualNumControllers;

  //异常单选弹框
  _getExceptionDialog(context, List expData, int whichRow, var carMap) {
    _expOnTapFlag = false;
    _expOnTap[whichRow] = false;
    setState(() {
    });
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('异常处理'),
          children: expData.map((exception) {
            return SimpleDialogOption(
              child: Text(exception['title']),
              onPressed: () async {
                var data = await DataDao.reportException(widget.sk, carMap['car_inout_id'], carMap['id'], exception['id']);
                if(data[0]['description'] != null) {
                  Fluttertoast.showToast(msg: '${data[0]['description']}');
                }
//                _expOnTapFlag = false;
//                _expOnTap[whichRow] = false;
                setState(() {
                });
              },
            );
          }).toList(),
        );
      }
    );
  }

  //表格
  showTable(List carData, List wareData, List partPacksData, List expData) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(100),
          1: FixedColumnWidth(100),
          2: FixedColumnWidth(100),
          3: FixedColumnWidth(100),
          4: FixedColumnWidth(100),
          5: FixedColumnWidth(100),
          6: FixedColumnWidth(100),
          7: FixedColumnWidth(200),
          8: FixedColumnWidth(100),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(width: 1),
        children: _tableList(carData, wareData, partPacksData, expData),
      ),
    );
  }

  //表格数据
  List<TableRow> _tableList(List carData, List wareData, List partPacksData, List expData) {
    TableRow _tableRow;
    _wareList = wareData;
    List<TableRow> _tableRowList = <TableRow>[
      TableRow(
        children: titleList.map((title) => _getTitleContainer(title)).toList()
      )
    ];

    if(_firstCreate) {
      _batchControllers = List(carData.length);
      _actualNumControllers = List(carData.length);
      packsValues = List(carData.length);
      unitValues = List(carData.length);
      _firstCreate = false;
    }

    for(int i=0;i<carData.length;i++) {
      _batchControllers[i] = TextEditingController();
      _actualNumControllers[i] = TextEditingController();
      _batchControllers[i].value = TextEditingValue(text: (_batchMap[i] ?? carData[i]['batch']));
      _tableRow = TableRow(
        children: <Widget>[
          TableRowInkWell(
            onTap: () {
              if(_expOnTap[i]) {
                _getExceptionDialog(context, expData, i, carData[i]);
              }

            },
            child: _getOrderNoContainer(carData[i]['order_no'], i),//采购订单号
          ),
          _getBatchEdit(i),//供应商批次
          _getContentContainer(carData[i]['part_title']),//物料名称
          _getContentContainer(carData[i]['plan_qty']),//计划数量
          _getActualNumEdit(_numMap[i] ?? '${carData[i]['plan_qty']}', i),//实际数量
          _getContentContainer(carData[i]['produce_date']),//生产日期
          _getDetachButton(context, _wareList, carData[i]),//拆分
          _getPartPacksSpinner(partPacksData, i),//包装明细
          _getUnitSpinner(i),//散托
        ]
      );
      _tableRowList.add(_tableRow);
    }
    return _tableRowList;
  }

  //表格标题
  Widget _getTitleContainer(title) {
    return Container(
      height: 50,
      color: Theme.of(context).primaryColor,
      child: Center(child: Text(title, style: WMConstant.middleTextWhite,),),
    );
  }

  //表格内容文本控件
  _getContentContainer(content) {
    return Container(
        height: 50,
        child: Center(
          child: Padding(padding: EdgeInsets.all(5), child: Text('$content'),),
        )
    );
  }

  //采购订单号
  _getOrderNoContainer(content, int whichRow) {
    return Container(
        height: 50,
        child: Center(
          child: Padding(padding: EdgeInsets.all(5), child: resultFlag == null ? Text('$content') : resultFlag[whichRow] ? Text('$content', style: TextStyle(color: Colors.green),) : Text('$content', style: TextStyle(color: Colors.red),),),
        )
    );
  }

  //表格内容实际数量编辑控件
  _getActualNumEdit(String num, int whichRow) {
    _actualNumControllers[whichRow].value = TextEditingValue(text: num);
    return Container(
      height: 50,
      child: _expOnTap[whichRow] ? Center(
        child: Padding(padding: EdgeInsets.all(5), child: Text(num),),
      ) : TextField(
        autofocus: false,
        controller: _actualNumControllers[whichRow],
        maxLines: 2,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.edit,size: 20,)
        ),
        onChanged: (value) {
          _numMap[whichRow] =  value;
        },
      ),
    );
  }

  //表格内容供应商批次编辑控件
  _getBatchEdit(int whichRow) {
    return Container(
      height: 50,
      child: TextField(
        autofocus: false,
          controller: _batchControllers[whichRow],
          maxLines: 2,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.edit,size: 20,)
          ),
          onChanged: (value) {
            _batchMap[whichRow] = value;
          },
        ),
    );
  }

  //拆分按钮
  _getDetachButton(context, List wareList, var carMap) {

    TextEditingController _detachNumController = TextEditingController();
    TextEditingController _detachBatchController = TextEditingController();

    var num = '';
    var batch = '';

    List<DropdownMenuItem> iWareItems = List();

    var iWareValue;

    _detachMaterial() async {
      var data = await DataDao.detachMaterial(widget.sk, '${carMap['car_id']}', '${carMap['id']}', wareList[iWareValue]['ware_id'], num, batch);
      //TODO 返回数据问题
      if(data[0]['description'] != null) {
        Fluttertoast.showToast(msg: '${data[0]['description']}');
      }else {
        Fluttertoast.showToast(msg: '拆分失败');
      }
      _futureStr = _getWareDetail();
      _expOnTapFlag = true;//实际数量不可编辑，可异常上报
      setState(() {
      });
    }

    _contentWidget() {
      //仓库下拉数据
      iWareItems.clear();
      DropdownMenuItem item;
      for(int i = 0;i < wareList.length;i++) {
        item = DropdownMenuItem(
          child: Text(wareList[i]['ware_name'],style: TextStyle(fontSize: 12),),
          value: i,
        );
        iWareItems.add(item);
      }
      if(wareList.length == 0) {
        Fluttertoast.showToast(msg: '暂无仓库数据');
      }else if(_detachFlag) {
        for(int i=0;i<wareList.length;i++) {
          if(wareList[i]['ware_name'] == widget.wareName) {
            iWareValue = i;
          }
        }
      }
      return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 250,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('数量：', style: TextStyle(fontSize: 15),),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText:'请输入拆分数量',
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter(RegExp('[0-9.]')),//只输入小数
                          ],
                          onChanged: (String value){
                            num = value;
                          },
                          controller: _detachNumController,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('供应商批次：', style: TextStyle(fontSize: 15),),
                    Expanded(child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText:'请输入供应商批次',
                          hintStyle: TextStyle(fontSize: 12)
                        ),
                        onChanged: (String value){
                          batch = value;
                        },
                        controller: _detachBatchController,
                      ),
                    ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('库位：', style: TextStyle(fontSize: 15),),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: iWareItems,
                          value: iWareValue,
                          elevation: 24,
                          onChanged: (v) {
                            setState(() {
                              _detachFlag = false;
                              iWareValue = v;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return FlatButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('分库操作'),
              content: _contentWidget(),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('取消'),
                ),
                FlatButton(
                  onPressed: () {
                    if(num == '' || batch == '') {
                      Fluttertoast.showToast(msg: '数量或批次不能为空');
                    }else {
                      if(double.parse(num) <= double.parse('${carMap['plan_qty']}')) {
                        //拆分操作
                        _detachMaterial();
                        Navigator.of(context).pop();
                      }else {
                        Fluttertoast.showToast(msg: '拆分数量应小于实际数量');
                      }
                    }
                  },
                  child: Text('提交'),
                ),
              ],
            );
          }
        );
      },
      child: Text('拆分'),
    );//拆分
  }

  //包装明细下拉控件
  _getPartPacksSpinner(List partPacksData, int whichRow) {

    List<DropdownMenuItem> packsItems = List();

    packsItems.clear();
    DropdownMenuItem item;
    for(int i = 0;i < partPacksData.length;i++) {
      item = DropdownMenuItem(
        child: Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(partPacksData[i]['title']),
        ),
        value: partPacksData[i]['id'],
      );
      packsItems.add(item);
    }
    if(partPacksData.length == 0) {
      Fluttertoast.showToast(msg: '暂无包装明细');
    }else if(_packsFirstFlag) {
      packsValues[whichRow] = partPacksData[0]['id'];
      _packsMap[whichRow] = packsValues[whichRow];
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        items: packsItems,
        value: packsValues[whichRow],
        elevation: 24,
        onChanged: (v) {
          setState(() {
            _packsFirstFlag = false;
            packsValues[whichRow] = v;
            _packsMap[whichRow] = packsValues[whichRow];
          });
        },
      ),
    );
  }

  //散托单位控件
  _getUnitSpinner(int whichRow) {

    List<DropdownMenuItem> unitItems = [
      DropdownMenuItem(
        child: Container(
          padding: EdgeInsets.only(left: 10),
          child: Text('散',textAlign: TextAlign.center,),
        ),
        value: '散',
      ),
      DropdownMenuItem(
        child: Container(
          padding: EdgeInsets.only(left: 10),
          child: Text('托',textAlign: TextAlign.center,),
        ),
        value: '托',
      )
    ];

    if(_unitFirstFlag) {
      unitValues[whichRow] = '散';
      _unitMap[whichRow] = unitValues[whichRow];
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        items: unitItems,
        value: unitValues[whichRow],
        elevation: 24,
        onChanged: (v) {
          setState(() {
            _unitFirstFlag = false;
            unitValues[whichRow] = v;
            _unitMap[whichRow] = unitValues[whichRow];
          });
        },
      ),
    );
  }

  //list转字符串，逗号隔开
  _listToString(list) {
    StringBuffer stringBuffer = StringBuffer();
    if(list != null && list.length > 0) {
      for(int i=0;i<list.length;i++) {
        stringBuffer.write(list[i]);
        if(i != list.length - 1) {
          stringBuffer.write(',');
        }
      }
    }
    return stringBuffer.toString();
  }

  //入库
  wareHouse(context) async {
    _loadIdList = List(carData.length);
    _numList = List(carData.length);
    _batchList = List(carData.length);
    for(int i=0;i<carData.length;i++) {
      _loadIdList[i] = carData[i]['id'];
      if(_numMap[i] != null) {
        _numList[i] = _numMap[i];
      }else {
        _numList[i] = carData[i]['plan_qty'];
      }
      if(_batchMap[i] != null) {
        _batchList[i] = _batchMap[i];
      }else {
        _batchList[i] = carData[i]['batch'];
      }
    }
    String loadIdStr = _listToString(_loadIdList);
    String numStr = _listToString(_numList);
    String batchStr = _listToString(_batchList);
    String packsStr = _listToString(_packsMap);
    String unitStr = _listToString(_unitMap);

    var data = await DataDao.wareHouse(widget.sk, loadIdStr, numStr, batchStr,
        wareData[wareValue]['ware_id'], packsStr, unitStr);
    //入库返回信息清单
    if(data != null) {
      _showWareHouseDialog(context, data);
      _expOnTapFlag = true;//实际数量不可编辑，可异常上报
      setState(() {
      });
    }

  }

  _showWareHouseDialog(context, data) {
    List tempData = List(_loadIdList.length);
    resultFlag = List(_loadIdList.length);
    for(int i=0;i<_loadIdList.length;i++) {
      tempData[i] = data['${_loadIdList[i]}'];
      if(data['${_loadIdList[i]}']['status'] == 0) {
        resultFlag[i] = false;
      }else {
        resultFlag[i] = true;
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('入库信息'),
          content: ListView(
            children: tempData.map((tempMap) {
              return ListTile(
                title: tempMap['status'] == '0' ?
                Text('${tempMap['description']} 入库失败！') :
                Text('${tempMap['description']} 入库成功！'),
              );
            }).toList(),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('入库单信息'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              wareHouse(context);
            },
            child: Text('入库', style: WMConstant.normalTextWhite,),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
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
                  detailData = snapshot.data;
                  carData = detailData['carLoadings'];
                  expData = detailData['rtCarCauses'];
                  wareData = detailData['ctWmWares'];
                  partPacksData = detailData['ctWmPartPacks'];

                  if(_expOnTapFlag) {
                    _expOnTap = List(carData.length);
                    for(int i=0;i<carData.length;i++) {
                      _expOnTap[i] = true;
                    }
                  }

                  //仓库下拉数据
                  wareItems.clear();
                  DropdownMenuItem item;
                  for(int i = 0;i < wareData.length;i++) {
                    item = DropdownMenuItem(
                      child: Text(wareData[i]['ware_name']),
                      value: i,
                    );
                    wareItems.add(item);
                  }
                  if(wareData.length == 0) {
                    Fluttertoast.showToast(msg: '暂无仓库数据');
                  }else if(_firstFlag) {
                    for(int i=0;i<wareData.length;i++) {
                      if(wareData[i]['ware_name'] == widget.wareName) {
                        wareValue = i;
                      }
                    }
                  }

                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('供应商名称：'),
                            Padding(padding: EdgeInsets.all(10), child: Text(carData[0]['supplier_name']),)
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('仓 库  名 称：'),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  items: wareItems,
                                  value: wareValue,
                                  elevation: 24,
                                  onChanged: (v) {
                                    setState(() {
                                      _firstFlag = false;
                                      wareValue = v;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        showTable(carData, wareData, partPacksData, expData),
                      ],
                    ),
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
      ),
    );
  }
}

