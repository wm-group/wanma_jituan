import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/net/url_constant.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:wanma_jituan/page/gfz/industry/production_line/progressbar.dart';

class ProductionLine extends StatefulWidget {
  ProductionLine({Key key}) : super(key: key);
  @override
  _ProductionLineState createState() => _ProductionLineState();
}

class _ProductionLineState extends State<ProductionLine> {
    List<dynamic> _deptList = [];
  String _deptStr = '';
  String _dateStr = '';
  List _eachLineDate = [];
  List <Widget>_tabelTitleDate = [_titleWidget('线号／日期')];
  List _tabelRowDate = [];
  Future _getProductLine(dept,lineDate) async{
      var data = DataDao.getException(dept, lineDate, UrlConstant.getProductLine());
      data.then((list){_eachLineDate=[]; _eachLineDate=list;});
      return data;
    }
  Future _getProductLineTable(dept,lineDate) async{
       var data = DataDao.getException(dept, lineDate, UrlConstant.getProductLineTable());
       data.then((list){
        viewAdd(list);
       });
      return data;
    }
  Future _getDept() async{
      var data =DataDao.getExceptionProductDept('1008');
      return data;
    }
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
       _getProductLineTable(_deptStr, _dateStr);
           _getProductLine(_deptStr, _dateStr);

     });
    }); 

 
   
  }
 
 viewAdd(list){
  _tabelTitleDate = [_titleWidget('线号／日期')];
   _tabelRowDate = [];
        List tempList = list[0]["closelist"];
     for (var item in tempList) {
       String str = item['date_time'];
       str = str.substring(5,10);
       _tabelTitleDate.add(_titleWidget(str));
     }
     for (var item in list) {
        print(item['line_no']);
        List<Widget> tempWidget = [_listTitleStye(item['line_no'].toString()),];
       for (var items in item['closelist']) {
         tempWidget.add(_listTitleStye(items['close'].toString()),); 
        
       }
       _tabelRowDate.add(tempWidget);
     }
     
 }

  @override
  Widget build(BuildContext context) {
    final _mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:AppBar(
        title:Text('生产线运行日志'),
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
       future: _getProductLineTable(_deptStr, _dateStr),
       builder: (context,snapshot){
       switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
                case ConnectionState.done:
                  if(snapshot.hasError) {
                    return Container();
                  }else if(snapshot.hasData) { 
                 return  Container(
             child:Column(
          children: <Widget>[
            _deptTime(_deptStr, _dateStr),
            Container(
             height: _mediaHeight/2-100,
              child:_lineListView(_eachLineDate),
            ),
            Container(
              height: _mediaHeight/2,
              child:_tableView(_tabelTitleDate)
            )
          ],
        )
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
  //部门及日期选择
Widget _deptTime(dept,date){
 return Container(
   color: Colors.grey[700],
   child:Text(' 车间:'+_deptStr+'   (' +_dateStr+')',style: TextStyle(color:Colors.white),)
 );
}
Widget _lineListView(list){
  return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
        return  ProgressBar(modelList:list[index]['list']);
       },
      );
}
Widget _tableView(list){
   return ListView(
          children: <Widget>[
          Table(
           border: TableBorder.all(
             color: Colors.grey,
              width: 1.0,
              style: BorderStyle.solid,
                ),
              children: _tableList(context,_tabelTitleDate,_tabelRowDate),
               )
              ],
   );
}

  _tableList(context,_tabelTitleDate,_tabelRowDate){
  var count = _tabelRowDate.length;
  dynamic content;
  List<TableRow> tabelDataList = <TableRow>[
    //行标题
    TableRow(
      decoration: BoxDecoration(
         color: Theme.of(context).primaryColor,
        ),
      children: _tabelTitleDate
    )
  ];

  //列表数据
  for (var i = 0; i < count; i++) {
    content = TableRow(
      children: _tabelRowDate[i]
    );

    tabelDataList.add(content);
  }
  return tabelDataList;
 
}


//抬头非序小部件
static Widget  _titleWidget(String title){
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
          _getProductLine(_deptStr, _dateStr); 
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
        _getProductLine(_deptStr, _dateStr);
        });
        // print(_dateStr);
      }
    ).showDialog(context);
  }

}