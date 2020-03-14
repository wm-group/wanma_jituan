import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';

class BasePrice extends StatefulWidget {
  @override
  _BasePriceState createState() => _BasePriceState();
}

class _BasePriceState extends State<BasePrice> {
  // list _futureStr;
   Future _modelListFuture;
  @override
  void initState() {
    // TODO: implement initState
    _modelListFuture = _getOrderData();
    super.initState();
   }

  Future _getOrderData() async {
    String bukrs = '1008';
   var data = await DataDao.getBasePriceData(bukrs);
    
    print(data);
    return data;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('基准价'),
        
      ),
      
      body: FutureBuilder(
        future: _modelListFuture,
        builder:  (context, snapshot) {
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

      }
      
      )
    );  
  }
}


 _tableList(context,List modelList){
  var count = modelList.length;
  dynamic content;
  List<TableRow> tabelDataList = <TableRow>[
    TableRow(
      decoration: BoxDecoration(
         color: Colors.blue,
        ),
      children: [
          Text('物料名称',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
          Text('基准价',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),                    
          Text('生效日期',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
    ]
    )
  ];
  for (var i = 0; i < count; i++) {
    content = TableRow(
      children: [
        Center(child:Text(modelList[i]['wlmc'].toString())),
        Center(child:Text(modelList[i]['jzj'].toString())),
        Center(child:Text(modelList[i]['sxrq'].toString())),
      ]
    );
    tabelDataList.add(content);
  }
  return tabelDataList;
 
}

