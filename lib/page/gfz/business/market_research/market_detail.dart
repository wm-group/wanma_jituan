
import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';
import 'package:flutter_picker/flutter_picker.dart';

class MarketDetail extends StatefulWidget {
  @override
  _MarketDetailState createState() => _MarketDetailState();
}

class _MarketDetailState extends State<MarketDetail> {
   String _customerName='PVC';
   IconData _selectIcon = Icons.check_box;
   List _listFirst = [{'select':false,'name':'规划一'},{'select':true,'name':'规划二'},{'select':false,'name':'规划三'}];
   List _listSecond = [{'select':true,'name':'pvc'},{'select':true,'name':'化学交联'},{'select':false,'name':'超高压'},{'select':false,'name':'屏蔽料'},{'select':false,'name':'低烟无卤'},{'select':false,'name':'弹性体TEPETPU'}];
   List _listThree = [{'select':true,'name':'无'},{'select':false,'name':'录入超时'}];
  List _listF = [{'select':true,'name':'pvc'},{'select':true,'name':'线缆'},{'select':false,'name':'高分子材料'},{'select':false,'name':'电缆'}];


  TextEditingController _dController = TextEditingController();
  TextEditingController _zController = TextEditingController();
  TextEditingController _gController = TextEditingController();
  TextEditingController _alertController = TextEditingController();
  double _mediaWith ;

  

  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    _mediaWith =size.width;
    // final height =size.height;
    // print(height);
    return Scaffold(
      appBar: AppBar(
        title:Text('市场调研'),
        centerTitle:true,
        actions: <Widget>[
          Center(
            child:InkWell(child:Text('提 交',style: TextStyle(fontSize: 16),),onTap: (){
            showDialog(//弹出提示的方法
          context: context,
          builder: (context){
            return AlertDialog(//提示框组件
                title: Text("已成功提交"), 
                actions: <Widget>[
                  FlatButton(
                  child: Text('　确定　'),
                  onPressed: () {  
                       Navigator.pop(context, true);  
},
              )
                ],  
            );
          },
      );
          },)
          )
 
        ],
      ),
      body: 
      SingleChildScrollView(
        child: Container(
          // child:_customer()
         child: 
         Column(children: <Widget>[
            _customer(context),
            _common(' 竞争对手:',_listFirst,150),
            _last(' 竞争价格:',Icons.attach_money,_dController,'0.93'),
            _last('年用量(t):',Icons.show_chart,_zController,'200'),
            _last(' 主营领域:',Icons.settings_input_composite,_gController,'pvc材料'),
           
          ],)
        ),
      ),
    );

  }
//客户名称
Widget _customer(context){
 
  return Container(
    decoration: new BoxDecoration(
    border: new Border.all(width: 0.5, color: Colors.grey[700]),
  ),
    child: Row(
     children:[
       Text('客户名称:'),
       Icon(Icons.people,color: Colors.grey,),
       Column(children:[Text(_customerName),Container(color: Colors.blue,height: 1.0, width: _mediaWith-160.0, )]),
       IconButton(icon: Icon(Icons.expand_more,color: Colors.blue,size: 30,), onPressed: (){showPickerArray(context); })
     ]
    ),
  );
  
}
//战略规划等小部件
Widget _common(String title,List list,double containerHeight){
  // double leftHeight;
  Color boderColor =Colors.grey[700];
  // double containerHeight=150;
  double otherBttHeight=25;
  return Container(
    margin: EdgeInsets.only(bottom:0,left:1,right: 1),
    padding: EdgeInsets.only(bottom:0,right:0),
     decoration:  BoxDecoration(
       border:  Border.all(width: 0.5, color: boderColor),
  ),
    child: Row(
      children:[
       Container(
         width: 75,
       child: Text(title),
       ),
       Container(
         margin: EdgeInsets.only(right:0,),
         decoration: BoxDecoration(border:Border.all(width:0.5,color: boderColor)),
         height: containerHeight,
         width: _mediaWith-79,
         padding: EdgeInsets.only(bottom:0,right: 0),
         child:Column(
           children:[
             Container(
               padding: EdgeInsets.only(top: 10),
               height: containerHeight-otherBttHeight-2,
              //  width: _mediaWith-79,
               child: gridViewDefaultCount(list)),
            //  ),
             Container(
               color: Colors.grey[300],
               width:_mediaWith-79,
               height: otherBttHeight,
               margin: EdgeInsets.only(bottom:0),
               child:InkWell(
                 child:Text('其他 ',textAlign: TextAlign.center,style: TextStyle(color:Colors.blue[900]),),
                 onTap: (){
                   showDialog(context: context, child:_alert(list));
                  //  _alert(list);
                  //  print('+++');
                 },
                 
               ),
             ),
           ]
         )
         
           
       ),
      ]
    )
  );
  
}

//战略规划等小部件
Widget _last(String title,IconData icons,TextEditingController controller,String textStr ){
  // double leftHeight;
  Color boderColor =Colors.grey[700];
  // double containerHeight=100;
  // double otherBttHeight=25;
  return Container(
    margin: EdgeInsets.only(top:0,bottom:0,left:1,right: 1),
    padding: EdgeInsets.only(left:4,right:0),
     decoration:  BoxDecoration(
       border:  Border.all(width: 0.5, color: boderColor),
  ),
    child: Row(
      children:[
       Container(child: Text(title),width: 70,),
       Container(
         margin: EdgeInsets.only(right:0,),
         width: _mediaWith-78,
         decoration: BoxDecoration(border:Border.all(width:0.5,color: boderColor)),
         height: 65,
          child:Row(children: <Widget>[Icon(icons,color: Colors.blue[500],size: 20,),Expanded(child: _commonTextField(null,controller,textStr))],),
       ),
      ]
    )
  );
  
}
//
Widget _commonTextField(IconData icon ,TextEditingController controller,var value){
controller.value =TextEditingValue(text: value);
  return TextField(
      decoration: InputDecoration(
          prefixIcon: Icon(icon,color: Colors.blue[400],),
          
          ),
          controller: controller,
          
    );
    
}

Widget gridViewDefaultCount(List list) {
        return GridView.count(
          crossAxisCount: 3,
          scrollDirection: Axis.vertical,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 5/ 2,
          children: initListWidget(list),
        );
      }
    
      List<Widget> initListWidget(List list) {
        List<Widget> lists = [];
        for (int i =0;i<list.length;i++) {
        var item = list[i];
         bool _select = item['select'];
          if (_select) {
            _selectIcon = Icons.check_box;
          }else{
             _selectIcon = Icons.check_box_outline_blank;
          }
          lists.add( Row(children:[
              IconButton(icon: Icon(_selectIcon,size: 18,color: Colors.orange,), onPressed: (){
               setState(() {
                 if (_select) {
                   _selectIcon = Icons.check_box;
                 }else{
                   _selectIcon = Icons.check_box_outline_blank;
                 }
                 _select = !_select;
                 list[i]['select'] = _select;
                 print(_select);
               });
              }),
              Expanded(child: Text(item['name']),)
            ])
          );
        }
        return lists;
      }
    

//选择
showPickerArray(BuildContext context) {
  List itemList=['PVC','化学交联','超高压','硅烷交联','屏蔽料','低烟无卤','弹性体TPETPU'];
    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: [itemList], isArray: true),
        hideHeader: true,
        title: new Text("请选择客户名"),
        cancelText: '取消',
        confirmText: '确定',
        onConfirm: (Picker picker, List value) {
          setState(() {          
             _customerName=picker.getSelectedValues()[0];
          });
        }
    ).showDialog(context);
  }

Widget _alert(List list){

return    AlertDialog(
    
        title: Text('请输入新增项:'),
        content: SingleChildScrollView(
          child: ListBody(
          children:[
                             TextField(
                              decoration: InputDecoration(
                              prefixIcon: Icon(Icons.border_color,color: Colors.blue[400],),
                               ),
                               controller: _alertController,
                              )        
          ]
        ),
        ),
         actions: <Widget>[
              FlatButton(
                  child: Text('确定'),
                  onPressed: () {  
                    setState(() {
                      list.add({'select':true,'name':_alertController.text});
                      // print(list);
                    });
                       Navigator.pop(context, true);  
},
              )
         ],
          ); 
}

  }