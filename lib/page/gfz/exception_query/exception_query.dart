import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/net/url_constant.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';
import 'package:date_format/date_format.dart';
class ExceptionQuery extends StatefulWidget {
  ExceptionQuery({Key key}) : super(key: key);
  
  @override
  _ExceptionQueryState createState() => _ExceptionQueryState();
}

class _ExceptionQueryState extends State<ExceptionQuery> {
  List<dynamic> _deptList = [];
  String _deptStr = '';
  String _dateStr = '';
  @override
  void initState() {
     super.initState();
     var today = DateTime.now();
     _dateStr = formatDate(today, [yyyy, '/', mm, '/',dd]);
     _getDept().then((dataList){
    for (var item in dataList) {
       _deptList.add(item['department']);
     }
     _deptStr = _deptList[0];
     setState(() {
         _getExceptionQuery(_deptStr, _dateStr);

    });
    });
    
  }
    Future _getExceptionQuery(dept,lineDate) async{
      var data = DataDao.getException(dept, lineDate, UrlConstant.getException());
      return data;
    }
    Future _getDept() async{
      var data =DataDao.getExceptionProductDept('1008');
      return data;
    }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('异常查询'),
        centerTitle:true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.business), onPressed: (){
           showPickerArray(context);
          }),
          IconButton(icon: Icon(Icons.date_range), onPressed: (){
          showPickerDate(context);
          })
        ],
      ),
      body: FutureBuilder(
        future: _getExceptionQuery(_deptStr, _dateStr),
        builder:(context,snapshot){
        switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
                case ConnectionState.done:
                  if(snapshot.hasError) {
                    return Container();
                  }else if(snapshot.hasData) { 
                 return   ListView(
                       children: <Widget>[
                         _deptTime(_deptStr,_dateStr),
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
//部门及日期选择
Widget _deptTime(dept,date){
 return Container(
   color: Colors.grey,
   child:Text(' 车间:'+_deptStr+'   (' +_dateStr+')',style: TextStyle(color:Colors.white),)
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
          _titleWidget( '线号'),
          _titleWidget( '名称'),
          _titleWidget( '异常数'),
  ]
    )
  ];

  //列表数据
  for (var i = 0; i < count; i++) {
    content = TableRow(
      children: [
        InkWell(child:Text(modelList[i]['line_no'].toString(),textAlign: TextAlign.center,),
        onTap: (){
          NavigatorUtils.goExceptionQueryDetail(context,modelList[i]['line_no'].toString(),_dateStr);
        }),
        _listTitleStye(modelList[i]['line_name'].toString()),
        _listTitleStye(modelList[i]['count'].toString()),
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

showPickerArray(BuildContext context) {

     new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: [_deptList], isArray: true),
        hideHeader: true,
        title: new Text("请选择车间"),
        cancelText: '取消',
        confirmText: '确定',
        onConfirm: (Picker picker, List value) {
          setState(() {
          _deptStr = picker.getSelectedValues()[0];
          });
 
        }
    ).showDialog(context);
  



  
  
}
 showPickerDate(BuildContext context) {
    Picker(
      hideHeader: true,
      adapter: DateTimePickerAdapter(type: 7,isNumberMonth: true),
      title: Text("请选择日期"),
      cancelText: '取消',
      confirmText: '确定',
      selectedTextStyle: TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List value) {
        setState(() {
        _dateStr = formatDate((picker.adapter as DateTimePickerAdapter).value, [yyyy, '/', mm, '/',dd]);

        });
        // print(_dateStr);
      }
    ).showDialog(context);
  }


}