import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:flutter_picker/flutter_picker.dart';
class BasePrice extends StatefulWidget {
  @override
  _BasePriceState createState() => _BasePriceState();
}

class _BasePriceState extends State<BasePrice> {
  // list _futureStr;
   Future _modelListFuture;
   List<dynamic> _modelListData=[];
   List<dynamic> _tempList=[];
   final List<dynamic>  _selectNameList=[];//物料名称选择数据
   bool _isSearch = false;
   IconData _searchIcon=Icons.search;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    _modelListFuture = _getOrderData();
    super.initState();
   }

Widget _navWidget(){
  if (!_isSearch) {
     return Text('基准价');
  } else {
    return 
    // Column(
      // children: <Widget>[
       TextField(
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
          hintText: '请输入物料名相关字段查询',
          prefixIcon: Icon(Icons.search,color: Colors.white70,),
      
),
    onSubmitted: (text) {//内容提交(按回车)的回调
        print('submit $text');
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
         ],
         )
  ); 
           }
         setState(() {
           _modelListData = itemList;
         });
      },
    );
  }
 
}


  Future _getOrderData() async {
    String bukrs = '1008';
   var data = await DataDao.getBasePriceData(bukrs);
    for (var item in data) {
      _selectNameList.add(item['wlmc']);
    }
    return data;
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

          } else {
             _searchIcon = Icons.close;
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
              children: _tableList(context,),
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

 _tableList(context){
  var count = _modelListData.length;
  dynamic content;
  List<TableRow> tabelDataList = <TableRow>[
    TableRow(
      decoration: BoxDecoration(
         color: Theme.of(context).primaryColor,
        ),
      children: [
          _selectWidget('物料名称'),
          _titleWidget('基准价'),
          _titleWidget('生效日期')   ]
    )
  ];
  for (var i = 0; i < count; i++) {
    content = TableRow(
      children: [
        _listTitleStye(_modelListData[i]['wlmc'].toString()),
        _listTitleStye(_modelListData[i]['jzj'].toString()),
        _listTitleStye(_modelListData[i]['sxrq'].toString()),

      ]
    );
    tabelDataList.add(content);
  }
  return tabelDataList;
 
}
//列表字体样式
_listTitleStye(String textStr){
  return Container(padding: EdgeInsets.only(top:5,bottom:5),  child:  Text(textStr,style: TextStyle(),textAlign: TextAlign.center,));

}

//抬头非序小部件
Widget _titleWidget(String title){
    return Container(
      padding: EdgeInsets.only(top:5,bottom: 5),
     child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),

    );
}

//物料选择小部件
Widget _selectWidget(String title,){
    return Container(
      padding: EdgeInsets.only(top:5,bottom: 5),
     child: 
     InkWell(
       child:Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
                  Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                  Icon(Icons.expand_more,color: Colors.white,)
         ],
       ),
      onTap: (){
           _modelListData = _tempList;
           showPickerArray(context);
      },
     )

    );
}


showPickerArray(BuildContext context) {
 
 
  List itemList=[];
    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: [_selectNameList], isArray: true),
        hideHeader: true,
        title: new Text("请选择物料名"),
        cancelText: '取消',
        confirmText: '确定',
        onConfirm: (Picker picker, List value) {

          for (var item in _modelListData) {   
           if (item['wlmc']==picker.getSelectedValues()[0]) {
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