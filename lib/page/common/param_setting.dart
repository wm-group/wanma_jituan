import 'package:flutter/material.dart';

class ParamSetting extends StatefulWidget {
  @override
  _ParamSettingState createState() => _ParamSettingState();
}

class _ParamSettingState extends State<ParamSetting> {
  final TextEditingController _skController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('设置参数',),centerTitle: true,),
        body:SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height:MediaQuery.of(context).size.height-20,
              padding: EdgeInsets.only(left: 20,top: 20,right: 20,bottom: 100),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/login_background.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: <Widget>[
                  _skSetting(context,_skController),
                  _sureBtn()
                ],
              ),
            ),
          ) ,
        )

    );
  }


  Widget _skSetting (context, controller){
    return _commonTextFieldSet('sk值设置',controller);

  }

  Widget _commonTextFieldSet(content, TextEditingController editingController){

    return Container(
      padding: EdgeInsets.only(top: 20),
      child:   TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.settings_input_svideo),
          labelText: content,
          labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: 18
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.pink
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        obscureText: true,
        controller:editingController,
        onChanged: (String values){
        },


      ),

    );
  }


  Widget _sureBtn (){

    return InkWell(
      onTap: (){
        //TODO 保存设置的sk值
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(top: 35),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          //
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          '完成',
          style: TextStyle(color: Colors.white,fontSize: 18),
        ),
      ),
    );
  }

}