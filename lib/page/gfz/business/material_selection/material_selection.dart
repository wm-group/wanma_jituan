import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/json/json_string.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';

class MaterialSelection extends StatefulWidget {
  _MaterialSelectionState createState() => _MaterialSelectionState();
}

class _MaterialSelectionState extends State<MaterialSelection> {
  List mList;
  List childList;
  List<ExpandStateBean> expandStateList;  //开展开的状态列表,ExpandStateBean是自定义的类

  List dataList;

  bool isLoading = true;

  Future _getMaterialSelection() async {
    String bukrs = '1008';
    var data = await DataDao.getMaterialSelection(bukrs);
    return data;
  }

  Future _MaterialSelectionInsert(matnr) async {
    var data = await DataDao.MaterialSelectionInsert(matnr);
    return data;
  }

  Future _MaterialSelectionDel(matnr) async {
    var data = await DataDao.MaterialSelectionDel(matnr);
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List tempList = List();
    mList = List();
    childList = List();
    expandStateList=new List();
//    dataList = JsonDecoder().convert(JsonString.tempMaterialData);
    _getMaterialSelection().then((value) {
      dataList = value;
      for(int i = 0;i < dataList.length;i ++) {
        if(i == 0) {
          tempList.add(dataList[i]['wlzms']);
        }else if(dataList[i]['wlzms'] != dataList[i-1]['wlzms']) {
          tempList.add(dataList[i]['wlzms']);
        }
      }
      Map map;
      for(int i = 0;i < tempList.length; i++) {
        map = HashMap<String, dynamic>();
        map['index'] = i;
        map['data'] = tempList[i];
        map['flag'] = true;
        List tempChildList = List();
        for(Map m in dataList) {
          if(tempList[i] == m['wlzms']) {
//          HashMap map = new HashMap<String,String>();
//          map['wlzms'] = m['wlzms'];
//          map['wlz'] = m['wlz'];
//          map['wlmc'] = m['wlmc'];
//          map['flag'] = m['flag'];
            tempChildList.add(m);
          }
        }
        expandStateList.add(ExpandStateBean(i,false));
        ///有勾选的自动展开，子数据重复，暂时关闭
//      for(Map m in tempChildList) {
//        if(m['flag'] == '1') {
//          expandStateList.add(ExpandStateBean(i,true));
//          break;
//        }
//      }
        for(Map m in tempChildList) {
          if(m['flag'] == '0') {
            map['flag'] = false;
            break;
          }
        }
        mList.add(map);
        childList.add(tempChildList);
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  //构造方法，调用这个类的时候自动执行
//  _MaterialSelectionState(){
//
//  }

  //修改展开与闭合的内部方法
  _setCurrentIndex(int index,isExpand){
    setState(() {
      //遍历可展开状态列表
      expandStateList.forEach((item){
        if(item.index==index){
          //取反，经典取反方法
          item.isOpen=!isExpand;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('物料勾选'),
      ),
      //加入可滚动组件(ExpansionPanelList必须使用可滚动的组件)
      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) :
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('物料组', style: WMConstant.middleText,),
                  Text('物料名称', style: WMConstant.middleText,),
                  Text('勾选', style: WMConstant.middleText,),
                ],
              ),
            ),
            ExpansionPanelList(
              //交互回调属性，里面是个匿名函数
              expansionCallback: (index,bol){
                //调用内部方法
                _setCurrentIndex(index, bol);
              },
              children: mList.map((tempMap){
                List tempList = childList[tempMap['index']];
                //返回一个组成的ExpansionPanel
                return ExpansionPanel(
                    headerBuilder: (context,isExpanded){
                      return CheckboxListTile(
                        title: Text(tempMap['data']),
                        value: tempMap['flag'],
                        onChanged: (value) {
                          setState(() async {
                            //TODO 调用插入删除接口
                            for(Map m in tempList) {
                              if(value) {
//                                await _MaterialSelectionInsert(m['wlz']);
                                m['flag'] = '1';
                              }else {
//                                await _MaterialSelectionDel(m['wlz']);
                                m['flag'] = '0';
                              }
                            }
                            tempMap['flag'] = value;
                          });
                        },
                      );
                    },
                    body: Container(
                      height: 300,
                      child: ListView.builder(
                            itemCount: tempList.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                value: tempList[index]['flag'] == '1' ? true : false,
                                onChanged: (value) {
                                  setState(() {
                                    //TODO 调用插入删除接口
                                    if(value) {
                                      tempList[index]['flag'] = '1';
                                    }else {
                                      tempList[index]['flag'] = '0';
                                    }
                                  });
                                },
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(tempList[index]['wlzms'], style: TextStyle(fontSize: 13),),
                                    Text(tempList[index]['wlmc'], style: TextStyle(fontSize: 13),),
                                    Text('')
                                  ],
                                ),
                              );
                            },
                          ),
                    ),
                    isExpanded: expandStateList[tempMap['index']].isOpen
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

//list中item状态自定义类
class ExpandStateBean{
  var isOpen;   //item是否打开
  var index;    //item中的索引
  ExpandStateBean(this.index,this.isOpen);
}

