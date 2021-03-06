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
            await LocalStorage.save(Config.MODULE_CATEGORY, 'wmgfzandroid');

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
          case 'goMaterialSelection':
          //物料勾选
            NavigatorUtils.goMaterialSelection(context);
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
          case 'goDeliverDemand':
          //发货需求
            NavigatorUtils.goDeliverDemand(context);
            break;
          case 'goMarketResearch':
          //市场调研
            NavigatorUtils.goMarketResearch(context);
            break;
        //高分子工业4.0
        //4.0异常查询
          case 'goExceptionQuery':
            NavigatorUtils.goExceptionQuery(context);
            break;
          case 'goProductionLine':
          //4.0生产线运行日志
            NavigatorUtils.goProductionLine(context);
            break;
          case 'goLinesList':
          //生产线列表
            NavigatorUtils.goLinesList(context);
            break;
          case 'goLineHistory':
          //历史运行曲线
            NavigatorUtils.goLineHistory(context);
            break;
        //高分子-报表
        //成品发货
          case 'goGoodsRegistration':
            NavigatorUtils.goGoodsRegistration(context);
            break;
          case 'goMaterialStorage':
          //原材料入库
            NavigatorUtils.goMaterialStorage(context);
            break;
        // 成品入库列表
          case 'goGoodsStorageList':
            NavigatorUtils.goGoodsStorageList(context);
            break;
        // 原材料入库列表
          case 'goMaterialStorageList':
            NavigatorUtils.goMaterialStorageList(context);
            break;
        //特缆
          case 'goHomeTL':
          //特缆首页
            await LocalStorage.save(Config.MODULE_CATEGORY, 'androidTl');

            var userName = await LocalStorage.get(Config.USER_NAME_KEY);
            var password = await LocalStorage.get(Config.PW_KEY);
            DataDao.getAuthority(userName, password);
            NavigatorUtils.goHomeTL(context,mid);
            break;
        // 芯线生产量列表
          case 'goTLList':
            NavigatorUtils.goTLList(context);
            break;
        // 芯线月产量查询
          case 'goTLMonthQuery':
            NavigatorUtils.goTLMonthQuery(context);
            break;
        // 芯线异常查询
          case 'goTLExceptionQuery':
            NavigatorUtils.goTLExceptionQuery(context);
            break;
        // 半成品盘点
          case 'goTLInventory':
            NavigatorUtils.goTLInventory(context);
            break;
        //天屹
          case 'goHomeTY':
          //天屹首页
            await LocalStorage.save(Config.MODULE_CATEGORY, 'androidTl');

            var userName = await LocalStorage.get(Config.USER_NAME_KEY);
            var password = await LocalStorage.get(Config.PW_KEY);
            DataDao.getAuthority(userName, password);
            NavigatorUtils.goHomeTY(context,mid);
            break;
        // 半成品盘点
          case 'goTYInventory':
            NavigatorUtils.goTYInventory(context);
            break;
          default:
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('暂未开通')));
            break;
        }
      },
    );
  }
}
