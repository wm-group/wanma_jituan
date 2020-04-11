import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
// import 'post.dart';


class ClosingDetail extends StatefulWidget {
  final String kunnr;
  final String date;
  ClosingDetail({@required this.kunnr,@required this.date});
  
  @override
  _ClosingDetailState createState() => _ClosingDetailState();
}

class _ClosingDetailState extends State<ClosingDetail> {
   
  bool _sortAscending = true;
  List<dynamic> modelList;
  Future _modelListFuture;
  
   @override
  void initState() {
    _modelListFuture = _getClosingDetailsData();
    super.initState();
   }

  Future _getClosingDetailsData() async {
  String bukrs = '1008';
  var data = await DataDao.getCloseDetailsData(bukrs,widget.date,widget.kunnr);
  return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('成交明细'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future:  _modelListFuture,
        builder:  (context, snapshot) {
         
          switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
                case ConnectionState.done:
                  if(snapshot.hasError) {
                    return Container();
                  }else if(snapshot.hasData) { 
                     modelList = snapshot.data;
        return   ListView(
          children:[
               Table(
                border: TableBorder.all(
                color: Colors.grey,
                width: 1.0,
                style: BorderStyle.solid,
              ),
              children: _tableList(context, snapshot.data),)
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
          return b[title].compareTo(a[title]);}
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
        _sortTitleWidget( modelList, '物料描述', 'wlname'),
        _sortTitleWidget( modelList, '发出量', 'fcl'),
         _sortTitleWidget( modelList, '单价', 'dj'),
        _sortTitleWidget( modelList, '金额', 'je'),
        _sortTitleWidget( modelList, '发货日期', 'fhrq'),
          ]
    );
}

//列表
_listTableRow(context,int index,dynamic modelList){
return TableRow( 
      children: [
         _listTitleStye(modelList[index]['wlname'].toString()),
         _listTitleStye(modelList[index]['fcl'].toString()),
         _listTitleStye(modelList[index]['dj'].toString()),
         _listTitleStye(modelList[index]['je'].toString()),
         _listTitleStye(modelList[index]['fhrq'].toString()),
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


//列表字体样式
_listTitleStye(String textStr){
  return Container(padding: EdgeInsets.only(top:5,bottom:5), child:  Text(textStr,style: TextStyle(),textAlign: TextAlign.center,));

}
//标题字体样式
_headerTitle(String textStr){
  return  Text(textStr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,);
}
//抬头排序小部件
Widget _sortTitleWidget(dynamic modelList,String title,String keyName){
  return Container(
    padding: EdgeInsets.only(top:5,bottom: 5),
    child: 
    InkWell(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
             Icon(Icons.arrow_downward,color: Colors.white,size: 16,) ],),
          onTap: (){ _sort(keyName, modelList);}, ),
  );
}
}

