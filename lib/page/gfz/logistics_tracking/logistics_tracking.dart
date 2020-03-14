import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:date_format/date_format.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';
import 'package:flutter_picker/flutter_picker.dart';


class LogisticsTracking extends StatefulWidget {
  @override
  _LogisticsTrackingState createState() => _LogisticsTrackingState();
}

class _LogisticsTrackingState extends State<LogisticsTracking> {
   Future _modelListFuture;
   bool _sortAscending = true;
   List<dynamic> _modelListData=[];
   List<dynamic> _tempList=[];
    List<dynamic>  _selectNameList=[];//物料名称选择数据
   bool _isSearch = false;
   IconData _searchIcon=Icons.search;
   IconData _kehuSelectIcon =Icons.arrow_downward;
  TextEditingController controller = TextEditingController();
  String _navTitleName = '物流跟踪-本月';
  @override
  void initState() {
    _modelListFuture = _getLogisticsTrackingData();
    super.initState();
   }

  Future _getLogisticsTrackingData() async {
    String bukrs = '1008';
    var today = DateTime.now();
    int dayCount =  today.day;
    if (_navTitleName=='物流跟踪-上月') {
      today = today.add(Duration(days: -dayCount));
    }
    String s_date = formatDate(today, [yyyy, '-', mm, '-','01']);
    String e_date = formatDate(today, [yyyy, '-', mm, '-',dd]);  
    print('${e_date}  ++ ${s_date}');
    var data = await DataDao.getLogisticsTrackingData(bukrs,e_date,s_date);
    _selectNameList = [];
    _modelListData = [];
      for (var item in data) {
      _selectNameList.add(item['customer']);
    }
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
        title:_navWidget(),
        centerTitle: true,
        actions: <Widget>[
           IconButton(icon: Icon(_searchIcon), onPressed: (){
            setState(() {
              _isSearch = !_isSearch;
              if (!_isSearch) {
            _searchIcon = Icons.search;
            controller.text = '';
            _modelListData = [];
            _kehuSelectIcon =Icons.arrow_downward;

          } else {
             _searchIcon = Icons.close;
             _kehuSelectIcon =Icons.expand_more;
          }
              
            });
          }),
        PopupMenuButton(itemBuilder: (BuildContext context)=><PopupMenuItem <String>>[
          this._selectView(Icons.date_range, '本月', '1'),
          this._selectView(Icons.date_range, '上月', '2')
        ],
        onSelected: (String action){
          switch (action) {
            case '1':
            setState(() {
              _navTitleName = '物流跟踪-本月';
            _modelListFuture = _getLogisticsTrackingData();
            });
             break;
            case '2':
            setState(() {
               _navTitleName = '物流跟踪-上月';
              _modelListFuture = _getLogisticsTrackingData();
            });
              break;
            default:
          }
          
        },

        )
        ],
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
                    _tempList = snapshot.data;
                    if (_modelListData.isEmpty) {
                    _modelListData= snapshot.data;
                    }

        return ListView(
          children: <Widget>[
            Table(
                border: TableBorder.all(
                color: Colors.grey,
                width: 1.0,
                style: BorderStyle.solid,
              ),
              children: _tableList(context, _modelListData),
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
          final c = a;
          a = b;
          b = c;
        }
          return a[title].compareTo(b[title]);
        });
        });
       
}


//输入框查询小部件
  Widget _navWidget(){
  if (!_isSearch) {
     return Text(_navTitleName);
  } else {
    return  TextField(
         controller: this.controller,
          cursorColor: Colors.white,
          style: TextStyle(color:Colors.white),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
          hintStyle: TextStyle(
            color:Colors.white70,
            fontSize: 14
          ),       
          hintText: '请输入客户名相关字段查询',
          prefixIcon: Icon(Icons.search,color: Colors.white70,),
),
    onSubmitted: (text) {//内容提交(按回车)的回调
         List itemList=[];
         _modelListData = _tempList;
         for (var i = 0; i < _selectNameList.length; i++) {
           String itemStr = _selectNameList[i];
           if (itemStr.contains(text)) {
            itemList.add(_modelListData[i]);
          }
           }
      if (itemList.length==0) {
          showDialog(context: context, child: AlertDialog(
          content: new Text( "没有可以匹配的内容",
         ),
         actions: <Widget>[
              FlatButton(
                  child: Text('关闭'),
                  onPressed: () => Navigator.pop(context, true),
              )
         ], )); 
      }
         setState(() {
           _modelListData = itemList;
         });
      },
    ); }
}




 _tableList(context, modelList){
  var count = modelList.length;
  dynamic content;
  List<TableRow> tabelDataList = <TableRow>[
    //行标题
    TableRow(
      decoration: BoxDecoration(
         color: Colors.blue,
        ),
      children: [
          _sortTitleWidget(modelList, '客户','customer'),
          _sortTitleWidget( modelList, '发货日期','outdate'),
          _titleWidget( '司机电话'),
          _titleWidget( '车牌'),
          _titleWidget( '物流公司'),
  ]
    )
  ];





  //列表数据
  for (var i = 0; i < count; i++) {
    content = TableRow(
      children: [
        InkWell(child:Text(modelList[i]['customer'].toString()),
        onTap: (){
          NavigatorUtils.goLogisticsDetailsDetail(context, modelList[i]['vbeln'].toString());
        }),
        
        Container(padding: EdgeInsets.only(top:5,bottom:5), child:  Text(modelList[i]['outdate'].toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)),
        _listTitleStye(modelList[i]['phone'].toString()),
        _listTitleStye(modelList[i]['carnum'].toString()),
        _listTitleStye(modelList[i]['campany'].toString()),

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
//抬头排序小部件
Widget _sortTitleWidget(dynamic modelList,String title,String keyName){
   IconData iconName = Icons.arrow_downward;
   if (title=='客户') {
     iconName = _kehuSelectIcon;
   }else{
     iconName = Icons.arrow_downward;
   }
  return Container(
    padding: EdgeInsets.only(top:5,bottom: 5),
    child: InkWell(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
             Icon(iconName,color: Colors.white,size: 17,) ],),
          onTap: (){
    if (title=='客户') {
              if (_isSearch) {
                _modelListData = _tempList;
               showPickerArray(context);  
              }else{
                _sort(keyName, modelList);
              }
            }else{
             _sort(keyName, modelList);
            }
          }, ),
  );

}
showPickerArray(BuildContext context) {
  List itemList=[];
    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: [_selectNameList], isArray: true),
        hideHeader: true,
        title: new Text("请选择客户名"),
        cancelText: '取消',
        confirmText: '确定',
        onConfirm: (Picker picker, List value) {

          for (var item in _modelListData) {   
           if (item['customer']==picker.getSelectedValues()[0]) {
             itemList.add(item);
           }
         }
          setState(() {          
             _modelListData=itemList;
          });
        }
    ).showDialog(context);
  }

}
