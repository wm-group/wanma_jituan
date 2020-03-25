
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
class LogisticsDetail extends StatefulWidget {
   final String order_no;
  LogisticsDetail({@required this.order_no});
  @override
  _LogisticsDetailState createState() => _LogisticsDetailState();
}

class _LogisticsDetailState extends State<LogisticsDetail> {
  // list _futureStr;
   Future _modelListFuture;
  @override
  void initState() {
    // TODO: implement initState
    _modelListFuture = _getLogisticsDetailData();
    super.initState();
   }

  Future _getLogisticsDetailData() async {
    String order_no = widget.order_no;
   var data = await DataDao.getLogisticsDetailData(order_no);
    
    print(data);
    return data;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('物流明细'),
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
         _titleWidget('出库单号'),
         _titleWidget('签到地点'),
         _titleWidget('签到日期')
        
          ]
    )
  ];
  
  for (var i = 0; i < count; i++) {
    content = TableRow(
      children: [
        _listTitleStye(modelList[i]['vbeln'].toString()),
        _listTitleStye(modelList[i]['address'].toString()),
        _listTitleStye(modelList[i]['sign_time'].toString()),

      ]
    );
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

