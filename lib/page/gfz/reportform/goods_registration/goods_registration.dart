import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
class GoodsRegistration extends StatefulWidget {
  GoodsRegistration({Key key}) : super(key: key);

  @override
  _GoodsRegistrationState createState() => _GoodsRegistrationState();
}

class _GoodsRegistrationState extends State<GoodsRegistration> {
    String _loadingIdsString ;
    String _plan_qtyString;
    String _carName ='';
    List _carNameList = [];
    List _carNumerList = [];
    List _qtyList;
    Future _getCarGoodsFuture;
  @override
  void initState() { 
    super.initState();
      
    _getCar();
   
  }
    Future _getCar() async{
       var _sk = await LocalStorage.get(Config.SET_KEY);
       if(_sk==null) {
      Fluttertoast.showToast(msg: '请设置SK值');
      Navigator.of(context).pop();
    }else {
     var data =DataDao.getCar().then((list){
        for (var item in list['car_list'] ){
         _carNumerList.add(item['inout_id'].toString());
         _carNameList.add(item['plate_number'].toString()); }
        _carName = _carNameList[0];
        setState(() {
          _getCarGoodsFuture=_getCarGoods(_carNumerList[0]);
        });
      });
      return data;
    }
      
    }


    Future _getCarGoods(inoutId) async{
      var data =DataDao.getCarGoods(inoutId);
      return data;
    }


    Future _getUpdateCarGoods(loadingIds,qtys) async{
      var data =DataDao.getUpdateCarGoods(loadingIds, qtys).then((list){
          showDialog(context: context, child: AlertDialog(
          content: new Text( list[0]['description']),
          actions: <Widget>[
               FlatButton(
                  child: Text('确定'),
                  onPressed: () => Navigator.pop(context, true),
              )
         ], )); 
  });
      return data;
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('成品发货登记'),
        centerTitle: true,
        actions: <Widget>[
         MaterialButton(
           child: Text('确定'),
           textColor: Colors.white,
           onPressed: (){
           String qytyStr = '';
    if (_qtyList.length>0) {
        for (int i =0; i<_qtyList.length; i++) {
            qytyStr = _qtyList[i]+','+qytyStr;
        }
        _plan_qtyString = qytyStr;
        // print(_plan_qtyString);
        // print(_loadingIdsString);
        _getUpdateCarGoods(_loadingIdsString, _plan_qtyString);

    }
         })
        ],
      ),
      body: FutureBuilder(
       future: _getCarGoodsFuture,
       builder: (context,snapshot){
       switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
                case ConnectionState.done:
                  if(snapshot.hasError) {
                    return Container();
                  }else if(snapshot.hasData) { 
                    List tempList = snapshot.data['htWmCarLoadings'];
                    _upData(tempList);
                  return ListView(
                    children: <Widget>[
                      _selectWidget(),
                      Table(
                        border: TableBorder.all(
                           color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid,
                      ),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: _tableList(context, tempList),
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
  
 _upData(List list){
   _qtyList = [];
     String str1='';
     _loadingIdsString = '';
     _plan_qtyString = '';
     if (list.length>0) {
       for (var item in list) {
         _loadingIdsString = item['id'].toString();
         _plan_qtyString = item['plan_qty'].toString();
         str1 = _loadingIdsString+','+str1;
         _qtyList.add(_plan_qtyString);
       }
       _loadingIdsString = str1;
     }
 }
 Widget _selectWidget(){
   return Container(
     color: Colors.grey[200],
     height: 35,
     child: Row(
       children:[
         Icon(Icons.directions_car,color:Colors.orange),
         Text(' 车牌号 ',style: TextStyle(fontWeight: FontWeight.w600),),
         Container(
           child:Text(_carName, textAlign:TextAlign.center,),
           width:MediaQuery.of(context).size.width-125,
         ),
         IconButton(icon: Icon(Icons.expand_more,color:Colors.blue) , onPressed: (){
           showPickerArray(context);
         })
       ]
     ),
   );
 }

_tableList(context, modelList){
  
  var count = modelList.length;
  dynamic content;
  List<TableRow> tabelDataList = <TableRow>[
    //行标题
    TableRow(
      decoration: BoxDecoration(
         color:Colors.grey[200]
          // Theme.of(context).primaryColor,
        ),
      children: [
          _titleWidget( '物料名称'),
          _titleWidget( '发货单号'),
          _titleWidget( '项目号'),
          _titleWidget( '数量'),
  ]
    )
  ];

  //列表数据
  for (var i = 0; i < count; i++) {
    content = TableRow(
      children: [
        _listTitleStye(modelList[i]['part_name'].toString()),
        _listTitleStye(modelList[i]['object_no'].toString()),
        _listTitleStye(modelList[i]['order_no'].toString()),
        _quantityWidget(modelList[i]['plan_qty'].toString(),i,modelList),
      ]
    );

    tabelDataList.add(content);
  }
  return tabelDataList;
 
}
 //抬头非排序小部件
Widget _titleWidget(String title){
    return Container(
      padding: EdgeInsets.only(top:5,bottom: 5),
     child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),

    );
}
//列表字体样式
_listTitleStye(String textStr){
  if (textStr=='null') {
    textStr = ' ';
  }
  return Text(textStr,style: TextStyle(),textAlign: TextAlign.center,);

}
_quantityWidget(String textStr,index,modelList){
  TextEditingController controller = TextEditingController();
  controller.text = textStr;
 return  TextField(
         controller: controller,
          keyboardType: TextInputType.number,
          maxLines: 5,
          minLines: 1,
           autofocus: false, 
          decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 13),     
          prefixIcon: Icon(Icons.edit,size: 14,),
          
), onChanged: (text){
  // modelList[index]['plan_qty']=text;
  _qtyList[index] = text;
});
          // onSubmitted: (text) {//内容提交(按回车)的回调
          //  setState(() {
          //    modelList[index]['plan_qty']=text;
          //  });
          //  });
       }

showPickerArray(BuildContext context) {
     if (_carNameList.length>0) {
    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: [_carNameList], isArray: true),
        hideHeader: true,
        title: new Text("请选择车牌号"),
        cancelText: '取消',
        confirmText: '确定',
        onConfirm: (Picker picker, List value) {
          var nums = value[0];
          setState(() {
           
            _carName = picker.getSelectedValues()[0];
             _getCarGoodsFuture = _getCarGoods(_carNumerList[nums]);        
          });
        }
    ).showDialog(context);
  }else{
     showDialog(context: context, child: AlertDialog(
          content: new Text( "数据为空",
         ),
         actions: <Widget>[
              FlatButton(
                  child: Text('确定'),
                  onPressed: () => Navigator.pop(context, true),
              )
         ], )); 
         }
  }
       
     
}
