import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';

class MaterialStorage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('原材料入库'),
      ),
      body: MaterialStorageBody(),
    );
  }
}

class MaterialStorageBody extends StatefulWidget {
  @override
  _MaterialStorageBodyState createState() => _MaterialStorageBodyState();
}

class _MaterialStorageBodyState extends State<MaterialStorageBody> {

  var _sk;

  List carNoList;
  List wareList;

  List<DropdownMenuItem> carNoItems = List();
  List<DropdownMenuItem> wareItems = List();

  var carNoValue;
  var wareValue;

  var inoutId;
  var purpose;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCarNoList();
  }

  //获取车牌下拉数据
  _getCarNoList() async {
    _sk = await LocalStorage.get(Config.SET_KEY);
    if(_sk == null) {
      Fluttertoast.showToast(msg: '请去参数设置菜单设置SK值');
      Navigator.of(context).pop();
    }else {
      var tempList = await DataDao.getCarNoList(_sk);
      carNoList = tempList['index_list'];
      DropdownMenuItem item;
      for(int i = 0;i < carNoList.length;i++) {
        item = DropdownMenuItem(
          child: Text(carNoList[i]['plate_number']),
          value: carNoList[i]['plate_number'],
        );
        carNoItems.add(item);
      }
      if(carNoList.length == 0) {
        Fluttertoast.showToast(msg: '暂无数据');
      }else {
        carNoValue = carNoList[0]['plate_number'];
        _getWareList(carNoValue);
        setState(() {

        });
      }
    }
  }

  //获取库位下拉数据
  _getWareList(carNoValue) async{
    if(_sk == null) {
      Fluttertoast.showToast(msg: '请去参数设置菜单设置SK值');
      Navigator.of(context).pop();
    }else {
      var tempList = await DataDao.getWareList(_sk, carNoValue);
      wareList = tempList['ware_list'];
      wareItems.clear();
      DropdownMenuItem item;
      for(int i = 0;i < wareList.length;i++) {
        item = DropdownMenuItem(
          child: Text(wareList[i]['ware_name']),
          value: wareList[i]['ware_id'],
        );
        wareItems.add(item);
      }
      if(wareList.length == 0) {
        Fluttertoast.showToast(msg: '暂无数据');
      }else {
        wareValue = wareList[0]['ware_id'];
        setState(() {

        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('车牌信息：',style: WMConstant.middleText,),
              Padding(padding: EdgeInsets.all(20)),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: carNoItems,
                      value: carNoValue,
                      elevation: 24,
                      onChanged: (v) async {
                        await _getWareList(v);
                        setState(() {
                          carNoValue = v;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
          Row(
            children: <Widget>[
              Text('仓库信息：',style: WMConstant.middleText,),
              Padding(padding: EdgeInsets.all(20)),
              Expanded(
                child: Container(
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
                          wareValue = v;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.blue
            ),
            child: FlatButton(
              onPressed: () {
                for(Map map in carNoList) {
                  if(map['plate_number'] = carNoValue) {
                    inoutId = map['inout_id'];
                    purpose = map['purpose'];
                  }
                }
              },
              child: Text('确定'),
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}

