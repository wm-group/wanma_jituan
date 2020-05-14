import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';

class TLInventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('盘点任务'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text('输入随单码'),
                    children: <Widget>[
                      TextField(),
                      Padding(padding: EdgeInsets.all(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                            child: Text('取        消', style: WMConstant.normalTextWhite,),
                          ),
                          RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                            child: Text('开始任务', style: WMConstant.normalTextWhite,),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              );
            },
            child: Text('随单码录入', style: WMConstant.middleTextWhite,),
          ),
        ],
      ),
      body: InventoryBody(),
    );
  }
}

class InventoryBody extends StatefulWidget {
  @override
  _InventoryBodyState createState() => _InventoryBodyState();
}

class _InventoryBodyState extends State<InventoryBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '主键',
                    labelStyle: TextStyle(
                        color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: IconButton(
                  icon: Icon(Icons.search, size: 30,),
                  onPressed: () {
                  },
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}