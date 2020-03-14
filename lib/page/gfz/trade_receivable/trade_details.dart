import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:date_format/date_format.dart';
class TradeDetails extends StatefulWidget {
  final String custormer;
  final String kunnr;
  TradeDetails({@required this.custormer,@required this.kunnr});
  @override
  _TradeDetailsState createState() => _TradeDetailsState();
}

class _TradeDetailsState extends State<TradeDetails> {
  Future _modelListFuture;
   @override
  void initState() {
    _modelListFuture = _getTradeDetailsData();
    super.initState();
   }
  Future _getTradeDetailsData() async{
   String bukrs = '1008';
   String kunnr = widget.kunnr;
   var data =  await DataDao.getTradeDetailData(bukrs, kunnr);
   return data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.custormer),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _modelListFuture,
        builder: (context,snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          return Center(child:CircularProgressIndicator(semanticsLabel: '加载中...',));
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
                  }
            else{
          return Container();
        } break;
          default:
             return null;
          break;
        }
      }),
    );
  }
}
//标题
_titleTableRow(){
  return TableRow(
    decoration: BoxDecoration(
      color: Colors.blue
    ),
    children: [
      _titleWidget('期间'),
      _titleWidget('金额')
    ]
  );
}
//列表
_listTableRow(context,int index,List nameList,List valueList){
return TableRow( 
      children: [
         _listTitleStye(nameList[index]),
         _listTitleStye(valueList[index]),
            ],
    );
}


//标题栏+列表整合
 _tableList(context,dynamic modelList){

var today = DateTime.now();  


  List nameList =['本月账期'];
  List valueList =[modelList[0]['zero'].toString()];
  for (var i = 1; i < 6; i++) {
    var monthAgo = today.add(new Duration(days: -30*i));
    String month = formatDate(monthAgo, [mm]);
    if(i!=5){
      nameList.add('${month}月账期');
    }else{
      nameList.add('${month}月以前账期');
    }
    valueList.add(modelList[i]['zero'].toString());
  }
  dynamic content;
  print(nameList);
  print('====');
  print(valueList);
  List<TableRow> tabelDataList = <TableRow>[_titleTableRow()];
 
    
  for (var i = 0; i < modelList.length; i++) {
    content = _listTableRow(context, i, nameList, valueList);
    tabelDataList.add(content);
  }
  return tabelDataList;
 
}

//抬头非序小部件
Widget _titleWidget(String title){
    return Container(
      padding: EdgeInsets.only(top:5,bottom: 5),
     child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),

    );
}
//列表字体样式
_listTitleStye(String textStr){
  return Container(padding: EdgeInsets.only(top:5,bottom:5), child:  Text(textStr,style: TextStyle(),textAlign: TextAlign.center,));

}
