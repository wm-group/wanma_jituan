import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/net/url_constant.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';
import 'package:date_format/date_format.dart';

import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
class GoodsRegistration extends StatefulWidget {
  GoodsRegistration({Key key}) : super(key: key);

  @override
  _GoodsRegistrationState createState() => _GoodsRegistrationState();
}

class _GoodsRegistrationState extends State<GoodsRegistration> {
  var _sk;
  @override
  void initState() { 
    super.initState();
    initSk();
    print('==++++');
    
    
  }
    initSk() async{
    _sk = await LocalStorage.get(Config.SET_KEY);
    _getCarGoods(_sk);
    }
    Future _getCar(sk) async{
       
      var data =DataDao.getCar(sk);
       print('==');
      print(data);
      return data;
    }
    Future _getCarGoods(sk) async{
       var inoutId='1498528544897007';
      var data =DataDao.getCarGoods(inoutId, sk);
       print('==');
      print(data);
      return data;
    }
      Future _getUpdateCarGoods(loadingIds,qtys,sk) async{
      var data =DataDao.getUpdateCarGoods(loadingIds, qtys, _sk);
       print('==');
      print(data);
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
          print('object');
         })
        ],
      ),
      body: Container(
      child: _selectWidget(),
      ),
    );
  }

 Widget _selectWidget(){
   return Container(
     height: 40,
     child: Row(
       children:[
         Icon(Icons.directions_car,color:Colors.orange),
         Text('车牌号 '),
         Material(
         borderRadius: BorderRadius.circular(13.0),
         shadowColor: Colors.blue.shade200,
         elevation: 10.0,
         child:  MaterialButton(
         onPressed: (){},
         minWidth: MediaQuery.of(context).size.width-120,
         height: 40,
         child:Text('Buy Now'),
  ),
),

         IconButton(icon: Icon(Icons.arrow_drop_down,color:Colors.blue) , onPressed: null)
       ]
     ),
   );
 }
}
