import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';
import 'package:flutter_picker/flutter_picker.dart';

class IssueSituation extends StatefulWidget {
  @override
  _IssueSituationState createState() => _IssueSituationState();
}

class _IssueSituationState extends State<IssueSituation> {
   Future _modelListFuture;
   bool _sortAscending = true;
   List<dynamic> _modelListData=[];
   List<dynamic> _tempList=[];
   final List<dynamic>  _selectNameList=[];//物料名称选择数据
   bool _isSearch = false;
   IconData _searchIcon=Icons.search;
   IconData _kehuSelectIcon =Icons.arrow_downward;
  TextEditingController controller = TextEditingController();


  @override
  void initState() {
    _modelListFuture = _getIssueSituationData();
    super.initState();
   }

  Future _getIssueSituationData() async {
    String bukrs = '1008';
   var data = await DataDao.getIssueSituationData(bukrs);
      for (var item in data) {
      _selectNameList.add(item['khname']);
    }
    return data;
  }

//输入框查询小部件
  Widget _navWidget(){
  if (!_isSearch) {
     return Text('发出情况');
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
          })
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
        _sortTitleWidget( modelList, '客户', 'khname'),
        _sortTitleWidget( modelList, '发出量', 'fcl'),
        _sortTitleWidget( modelList, '金额(万)', 'je'),
        _sortTitleWidget( modelList, '月份', 'yf'),
          ]
    );
}
//列表
_listTableRow(context,int index,dynamic modelList){
return TableRow( 
      children: [
        InkWell(
         child:_listTitleStye(modelList[index]['khname'].toString()),
         onTap: (){
           NavigatorUtils.goCloseingDetail(context, modelList[index]['kh'], modelList[index]['yf']);
         },
        ),
        
         _listTitleStye(modelList[index]['fcl'].toString()),
         _listTitleStye(modelList[index]['je'].toString()),
         _listTitleStye(modelList[index]['yf'].toString()),
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
    child: 
    InkWell(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
             Icon(iconName,color: Colors.white,size: 16,) ],),
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
           if (item['khname']==picker.getSelectedValues()[0]) {
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

// Widget createAlertDialog(){
//     return new AlertDialog(
//       contentPadding: EdgeInsets.all(10.0),
//       title: new Text('我是标题'),
//       content: new Text('我是内容'),
//       actions: <Widget>[
//         new FlatButton(
//           child: new Text('确定'),
//           onPressed: () {
//             Navigator.of(context).pop();//关闭对话框
//           },
//         ),

//         new FlatButton(
//           child: new Text('取消'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }