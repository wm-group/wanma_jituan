
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';
import 'package:date_format/date_format.dart';

class TradeReceivable extends StatefulWidget {
  @override
  _TradeReceivableState createState() => _TradeReceivableState();
}

class _TradeReceivableState extends State<TradeReceivable> {
   Future _modelListFuture;
   bool _sortAscending = true;
  @override
  void initState() {
    _modelListFuture = _getTradeReceivableData();
    super.initState();
   }

  Future _getTradeReceivableData() async {
    String bukrs = '1008';
    var today = DateTime.now();
    String s_date = formatDate(today, [yyyy, '-', mm, '-', '01']);
    String e_date = formatDate(today, [yyyy, '-', mm, '-', dd]);
   var data = await DataDao.getTradeReceivableData(bukrs,s_date,e_date);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('应收货款'),
        centerTitle: true,
      ),
      
      body: FutureBuilder(
        future: _modelListFuture,
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
              children: _tableList(context, snapshot.data),
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
//排序
  _sort( String title,List<dynamic> modelList){
          _sortAscending = !_sortAscending;
          setState(() {   
           modelList.sort((a,b){
          if(!_sortAscending) {
          return a[title].compareTo(b[title]);
        }else{
          return b[title].compareTo(a[title]);
        }
        });   
        });   
}


//标题栏
_titleTableRow(modelList){
  return  TableRow(
      decoration: BoxDecoration(
         color: Theme.of(context).primaryColor,
        ),
      children: [
        _sortTitleWidget(modelList, '客户↓', 'customer'),
        _sortTitleWidget(modelList, '应收总额(万)↓', 'ysze'),
        _sortTitleWidget(modelList, '本月计划回款(万)↓', 'yshk'),
        _sortTitleWidget(modelList, '本月回款(万)↓', 'yhk'),
        _sortTitleWidget(modelList, '约定账期↓', 'ydzq'),
        _sortTitleWidget(modelList, '实际账期↓', 'sjhlzq'),
          ]
    );
}
//列表
_listTableRow(context,int index,dynamic modelList){
return TableRow( 
      children: [
        InkWell(
         child:_listTitleStye(modelList[index]['customer'].toString()),
         onTap: (){
           NavigatorUtils.goTradeDetailsDetail(context, modelList[index]['customer'], modelList[index]['cusid']);
         },
        ),
         _listTitleStye(modelList[index]['ysze'].toString()),
         _listTitleStye(modelList[index]['yshk'].toString()),
         _listTitleStye(modelList[index]['yhk'].toString()),
          _listTitleStye(modelList[index]['ydzq'].toString()),
         _listTitleStye(modelList[index]['sjhlzq'].toString()),
            ],
    );
}

//标题栏+列表整合
 _tableList(context,dynamic modelList){
  var count = modelList.length;
  dynamic content;
  List<TableRow> tabelDataList = <TableRow>[_titleTableRow(modelList)];
  for (var i = 0; i < count; i++) {
    content = _listTableRow(context, i, modelList);
    tabelDataList.add(content);
  }
  return tabelDataList;
 
}



//抬头排序小部件
Widget _sortTitleWidget(dynamic modelList,String title,String keyName){
  return Container(
    padding: EdgeInsets.only(top:5,bottom: 5),
    child: InkWell(
          child:
             Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),            
          onTap: (){  _sort(keyName, modelList);}, ),
  );
}

//列表字体样式
_listTitleStye(String textStr){
  return Container(padding: EdgeInsets.only(top:5,bottom:5), child:  Text(textStr,style: TextStyle(),textAlign: TextAlign.center,));

}
}