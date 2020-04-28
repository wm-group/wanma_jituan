import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GoodsStorageList extends StatefulWidget {
  GoodsStorageList({Key key}) : super(key: key);

  @override
  _GoodsStorageListState createState() => _GoodsStorageListState();
}

class _GoodsStorageListState extends State<GoodsStorageList> {
    Future _modelListFuture;
    Future _getGoodsStorageListData() async{
     var _sk = await LocalStorage.get(Config.SET_KEY);
    if(_sk==null) {
      Fluttertoast.showToast(msg: '请设置SK值');
      Navigator.of(context).pop();
    }else {
     var data = DataDao.getGoodsStorageList(_sk);
    return data;
    }
    
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelListFuture = _getGoodsStorageListData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('成品入库列表'),
        centerTitle:true
      ),
      body: FutureBuilder(future: _modelListFuture,
       builder:  (context, snapshot) {
        switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
                case ConnectionState.done:
                  if(snapshot.hasError) {
                    return Container();
                  }else if(snapshot.hasData) { 
        return ListView(
          children: <Widget>[
            Table(
                border: TableBorder.all(
                color: Colors.grey,
                width: 1.0,
                style: BorderStyle.solid,
              ),
              children: _tableList(context, snapshot.data['rtlotworks']),
            )
          ],
        );
        }else{
          return Container();
        }
        break;
                default:
                  return null;
                  break;
              }
      }
      
      
      )
    );  
  }
}


 _tableList(context,dynamic modelList){
  var count = modelList.length;
  dynamic content;
  List<TableRow> tabelDataList = <TableRow>[
    TableRow(
      decoration: BoxDecoration(
         color: Theme.of(context).primaryColor,
        ),
      children: [
          _titleWidget('工单号'),
          _titleWidget('生产物料'),
          _titleWidget('数量'),
          _titleWidget('开工生产时间'),
          _titleWidget('预计入库时间'),
          _titleWidget('入库时间'),
          _titleWidget('设备'),
          _titleWidget('工单状态'),
          _titleWidget('批号'),
          _titleWidget('备注'),

    ]
    )
  ];
  for (var i = 0; i < count; i++) {
    content = TableRow(
      children: [
        _listTitleStye(modelList[i]['lot_id'].toString()),
        _listTitleStye(modelList[i]['part'].toString()),
        _listTitleStye(modelList[i]['qty'].toString()),
        _listTitleStye(modelList[i]['date'].toString()),
        _listTitleStye(modelList[i]['plan_time'].toString()),
        _listTitleStye(modelList[i]['entry_dat'].toString()),
        _listTitleStye(modelList[i]['eqp_description'].toString()),
        _listTitleStye(modelList[i]['status_name'].toString()),
        _listTitleStye(modelList[i]['batch_id'].toString()),
        _listTitleStye(modelList[i]['remark'].toString()),

      ]
    );
    tabelDataList.add(content);
  }
  return tabelDataList;
 
}
//列表字体样式
_listTitleStye(String textStr){
  return Container(padding: EdgeInsets.only(top:5,bottom:5), child:  Text(textStr,style: TextStyle(),textAlign: TextAlign.center,));

}
//抬头非序小部件
Widget _titleWidget(String title){
    return Container(
      padding: EdgeInsets.only(top:5,bottom: 5),
     child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),

    );}


