import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
class ExceptionQueryDetail extends StatefulWidget {
  final String lineNo;
  final String lineDate;
  ExceptionQueryDetail({@required this.lineDate,@required this.lineNo});
  @override
  _ExceptionQueryDetailState createState() => _ExceptionQueryDetailState();
}

class _ExceptionQueryDetailState extends State<ExceptionQueryDetail> {
  Future _getExceptionQueryDetailData(){
    var data = DataDao.getExceptionDetail(widget.lineNo, widget.lineDate);
    return data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     body: FutureBuilder(
       future: _getExceptionQueryDetailData(),
       builder: (context,snapshot){
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
                    ]
                  );
                   }else{
          return Container();
        }
        break;
                default:
                  return null;
                  break;
              }
     }),
    );
  }


_tableList(context, modelList){
  var count = modelList.length;
  dynamic content;
  List<TableRow> tabelDataList = <TableRow>[
    //行标题
    TableRow(
      decoration: BoxDecoration(
         color: Theme.of(context).primaryColor,
        ),
      children: [
          _titleWidget( '参数'),
          _titleWidget( '时间点'),
          _titleWidget( '设定值'),
          _titleWidget( '实际值'),
  ]
    )
  ];

  //列表数据
  for (var i = 0; i < count; i++) {
    content = TableRow(
      children: [
        _listTitleStye(modelList[i]['位号'].toString()),
        _listTitleStye(modelList[i]['日期'].toString()),
        _setVakueTitleStye(modelList[i]['限值'].toString()),
        _listTitleStye(modelList[i]['数值'].toString()),
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
//设定值字体样式
_setVakueTitleStye(String textStr){
  return Container(padding: EdgeInsets.only(top:5,bottom:5), child:  Text(textStr,style: TextStyle(color: Colors.red),textAlign: TextAlign.center,));

}
}