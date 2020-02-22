import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/utils/common_utils.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class GridItemWidget extends StatelessWidget {

  final String text;
  final String functionName;
  final String mid;

  GridItemWidget({Key key,this.text,this.functionName,this.mid}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CommonUtils.renderTab(Icons.line_style, text,size: 32.0,color: Theme.of(context).primaryColor),
     onTap: () {
        switch(functionName) {
          case 'goHomeGfz':
            NavigatorUtils.goHomeGfz(context,mid);
            break;
          case 'goOrderStatus':
            NavigatorUtils.goOrderStatus(context);
            break;
          default:
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('暂未开通')));
            break;
        }
      },
    );
  }
}

//class GridItemWidget extends StatefulWidget {
//  final String text;
//  final String functionName;
//
//  GridItemWidget({this.text,this.functionName});
//
//  @override
//  _GridItemWidgetState createState() => _GridItemWidgetState();
//}
//
//class _GridItemWidgetState extends State<GridItemWidget> {
//  @override
//  Widget build(BuildContext context) {
//    return InkWell(
//      child: CommonUtils.renderTab(Icons.line_style, widget.text,size: 32.0,color: Colors.deepOrange),
//      onTap: () {
//        switch(widget.functionName) {
//          case 'goHomeWuXi':
//            NavigatorUtils.goHomeWuXi(context);
//            break;
//          case 'goHomeGZ':
//            Scaffold.of(context).showSnackBar(SnackBar(content: Text('暂未开通')));
//            break;
//          case 'goHomeCQ':
//            Scaffold.of(context).showSnackBar(SnackBar(content: Text('暂未开通')));
//            break;
//          default:
//            break;
//        }
//      },
//    );
//  }
//}
