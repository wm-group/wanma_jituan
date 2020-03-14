import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:date_format/date_format.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';
class TargetSituation extends StatefulWidget {
  @override
  _TargetSituationState createState() => _TargetSituationState();
}

class _TargetSituationState extends State<TargetSituation> {
  // list _futureStr;
   Future _modelListFuture;
    String _nowMYear;
    String _beforeYears;
    String _navTitleStr;
  @override
  void initState() {
    // TODO: implement initState
     var today = DateTime.now();
    _nowMYear = formatDate(today, [yyyy]);
    _beforeYears = formatDate(today.add(Duration(days: -365)), [yyyy]);
    _navTitleStr = _nowMYear;
    _modelListFuture = _getTargetSituationData();
    super.initState();
    
   }

  Future _getTargetSituationData() async {
    String bukrs = '1008';
   var data = await DataDao.getTargetSituationData(bukrs,_nowMYear+'01');
    
    // print(data);
    return data;
  }
   Future _getBeforYearData() async {
    String bukrs = '1008';
    //  var today = DateTime.now();
        print(_beforeYears+'01');

   var data = await DataDao.getTargetSituationData(bukrs,_beforeYears+'01');
    return data;
  }
  _selectView(IconData icon,String text,String id){
    return new PopupMenuItem<String>(child:
     Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
           Icon(icon,color: Colors.blue,),
           Text(text)
        ],
    ) ,
    value: id,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(_navTitleStr),
        // Text('目标情况'),
        centerTitle: true,
        actions: <Widget>[
        PopupMenuButton(itemBuilder: (BuildContext context)=><PopupMenuItem <String>>[
          this._selectView(Icons.date_range, _nowMYear, '1'),
          this._selectView(Icons.date_range, _beforeYears, '2')
        ],
        // child: Text('data'),
        onSelected: (String action){
          switch (action) {
            case '1':
            setState(() {
            _modelListFuture = _getTargetSituationData();
            _navTitleStr = _nowMYear;            });
             break;
            case '2':
            setState(() {
              _modelListFuture = _getBeforYearData();
              _navTitleStr = _beforeYears;
            });
              break;
            default:
          }
          
        },

        )]
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
         color: Colors.blue,
        ),
      children: [
          _titleWidget('计划'),
          _titleWidget('实际发货'),
          _titleWidget('完成率'),
          _titleWidget('实际回款'),
          _titleWidget('月份'),

    ]
    )
  ];
  for (var i = 0; i < count; i++) {
    content = TableRow(
      children: [
        _listTitleStye(modelList[i]['jh'].toString()),
        _listTitleStye(modelList[i]['sjfh'].toString()),
        _listTitleStye(modelList[i]['wcl'].toString()),
        _listTitleStye(modelList[i]['sjhk'].toString()),
        _listTitleStye((i+1).toString()+'月'),

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

    );
}