import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/config/config.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/local/local_storage.dart';
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
     onTap: () async{
        switch(functionName) {
          case 'goHomeGfz':
            //材料板块首页
            var userName = await LocalStorage.get(Config.USER_NAME_KEY);
            var password = await LocalStorage.get(Config.PW_KEY);
            DataDao.getAuthority(userName, password);
            NavigatorUtils.goHomeGfz(context,mid);
            break;
          case 'goOrderStatus':
            //订单状态
            NavigatorUtils.goOrderStatus(context);
            break;
          case 'goDeliveryTracking':
            //发货跟踪
            NavigatorUtils.goDeliveryTracking(context);
            break;
          case 'goSaleMessage':
            //开票情况
            NavigatorUtils.goSaleMessage(context);
            break;
          case 'goPaymentWithdrawal':
            //货款回笼
            NavigatorUtils.goPaymentWithdrawal(context);
            break;
          case 'goIssueSituation':
            //发出情况
            NavigatorUtils.goIssueSituation(context);
            break;
          case 'goTargetSituation':
            //目标情况
            NavigatorUtils.goTargetSituation(context);
            break;
          case 'goBasePrice':
            //基准价
            NavigatorUtils.goBasePrice(context);
            break;
          case 'goTradeReceivable':
            //应收货款
            NavigatorUtils.goTradeReceivable(context);
            break;
          case 'goLogisticsTracking':
            //物流跟踪
            NavigatorUtils.goLogisticsTracking(context);
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
