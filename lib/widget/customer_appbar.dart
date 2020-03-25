import 'package:flutter/material.dart';

class CustomerAppbar extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  final List backList;
  final List selectNameList;
  List receiveList;
  CustomerAppbar(this.title, this.backList, this.selectNameList, this.receiveList);


  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }

  @override
  _CustomerAppbarState createState() => _CustomerAppbarState();
}

class _CustomerAppbarState extends State<CustomerAppbar> {

  bool _isSearch = false;
  IconData _searchIcon = Icons.search;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _navWidget(widget.title, widget.backList, widget.selectNameList, widget.receiveList),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            icon: Icon(_searchIcon),
          onPressed: () {
            setState(() {
              _isSearch = !_isSearch;
              if (!_isSearch) {
                _searchIcon = Icons.search;
                controller.text = '';
                widget.receiveList = [];

              } else {
                _searchIcon = Icons.close;
              }

            });
          },
        )
      ],
    );
  }

  //输入框查询小部件
  Widget _navWidget(title, backList, selectNameList, receiveList) {
    if(!_isSearch) {
      return Text(title);
    }else {
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
          for(var i = 0; i < selectNameList.length; i++) {
            String itemStr = selectNameList[i];
            if(itemStr.contains(text)) {
              itemList.add(backList[i]);
            }
          }
          if(itemList.length == 0) {
            showDialog(context: context, child: AlertDialog(
              content: new Text( "没有可以匹配的内容",
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('关闭'),
                  onPressed: () => Navigator.pop(context),
                )
              ], ));
          }
          setState(() {
            receiveList = itemList;
          });
        },
      ); }
  }
}
