import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
class MaterialStorageList extends StatefulWidget {
  MaterialStorageList({Key key}) : super(key: key);

  @override
  _MaterialStorageListState createState() => _MaterialStorageListState();
}

class _MaterialStorageListState extends State<MaterialStorageList> {
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
        title:Text('原材料入库列表'),
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
              children: _tableList(context, snapshot.data['lists']),
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
          _titleWidget('分类'),
          _titleWidget('原材料批次'),
          _titleWidget('供应商批次'),
          _titleWidget('供应商名称'),
          _titleWidget('库位'),
          _titleWidget('物料'),
          _titleWidget('数量'),
          _titleWidget('入库时间'),
         

    ]
    )
  ];
  for (var i = 0; i < count; i++) {
    content = TableRow(
      children: [
        _listTitleStye(modelList[i]['type'].toString()),
        _listTitleStye(modelList[i]['charg'].toString()),
        _listTitleStye(modelList[i]['batch'].toString()),
        _listTitleStye(modelList[i]['supplier_name'].toString()),
        _listTitleStye(modelList[i]['ware_id'].toString()),
        _listTitleStye(modelList[i]['part_title'].toString()),
        _listTitleStye(modelList[i]['curr_qty'].toString()),
        _listTitleStye(modelList[i]['in_date'].toString()),


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


