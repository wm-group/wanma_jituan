import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanma_jituan/page/Gfz/gfz_home_page.dart';
import 'package:wanma_jituan/page/app.dart';
import 'package:wanma_jituan/page/common/param_setting.dart';
import 'package:wanma_jituan/page/common/question_submission.dart';
import 'package:wanma_jituan/page/common/update_pwd.dart';
import 'package:wanma_jituan/page/common/version_update.dart';
import 'package:wanma_jituan/page/gfz/order_status/order_details.dart';
import 'package:wanma_jituan/page/gfz/order_status/order_goods_follow.dart';
import 'package:wanma_jituan/page/gfz/order_status/order_status.dart';
import 'package:wanma_jituan/page/login_page.dart';
import 'package:wanma_jituan/page/Gfz/gfz_home_page.dart';
import 'package:wanma_jituan/page/common/param_setting.dart';
import 'package:wanma_jituan/page/gfz/base_price/base_price.dart';//基准价
import 'package:wanma_jituan/page/gfz/target_situation/target_situation.dart';//目标情况
import 'package:wanma_jituan/page/gfz/issue_situation/issue_situation.dart';//发出情况
import 'package:wanma_jituan/page/gfz/issue_situation/closing_details.dart';//发出明细
import 'package:wanma_jituan/page/gfz/trade_receivable/trade_receivable.dart';//应收货款
import 'package:wanma_jituan/page/gfz/trade_receivable/trade_details.dart';//应收货款明细
import 'package:wanma_jituan/page/gfz/logistics_tracking/logistics_tracking.dart';//物流跟踪
import 'package:wanma_jituan/page/gfz/logistics_tracking/logistics_detail.dart';//物流明细

import 'package:wanma_jituan/page/gfz/delivery_tracking/delivery_tracking.dart';
import 'package:wanma_jituan/page/gfz/order_status/deliver_edit.dart';
import 'package:wanma_jituan/page/gfz/order_status/deliver_require.dart';
import 'package:wanma_jituan/page/gfz/order_status/order_details.dart';
import 'package:wanma_jituan/page/gfz/order_status/order_goods_follow.dart';
import 'package:wanma_jituan/page/gfz/order_status/order_status.dart';
import 'package:wanma_jituan/page/gfz/payment_withdrawal/payment_details.dart';
import 'package:wanma_jituan/page/gfz/payment_withdrawal/payment_withdrawal.dart';
import 'package:wanma_jituan/page/gfz/sale_message/sale_details.dart';
import 'package:wanma_jituan/page/gfz/sale_message/sale_message.dart';
import 'package:wanma_jituan/page/login_page.dart';

///导航栏
class NavigatorUtils {

  ///登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }
  ///主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, App.sName);
  }

  ///材料板块
  ///主页
  static goHomeGfz(BuildContext context, String mid) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GfzHomePage(mid),
      ),
    );
  }

  ///订单状态
  static goOrderStatus(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderStatus(),
        // builder: (context) => IssueSituation(),
        // builder: (context) => TargetSituation(),
        //  builder: (context) => BasePrice(),
        // builder: (context) => TradeReceivable(),
        // builder: (context) => LogisticsTracking(),

      ),
    );
  }

  ///订单状态明细页
  static goOrderDetails(BuildContext context, String cusId) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => OrderDetails(cusId: cusId),
      ),
    );
  }
///发出情况
  static goIssueSituation(BuildContext context ) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => IssueSituation(),
      ),
    );
  }///目标情况
  static goTargetSituation(BuildContext context,) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => TargetSituation(),
      ),
    );
  }///基准价
  static goBasePrice(BuildContext context,  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => BasePrice(),
      ),
    );
  }///应收货款
  static goTradeReceivable(BuildContext context,  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => TradeReceivable(),
      ),
    );
  }///物流跟踪
  static goLogisticsTracking(BuildContext context,  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => LogisticsTracking(),
      ),
    );
  }
  ///订单物流跟踪明细
  static goOrderGoodsFollow(BuildContext context, String vbeln, String posnr) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderGoodsFollow(vbeln, posnr),
      ),
    );
  }

  ///发货需求明细
  static goDeliverRequire(BuildContext context, String vbeln) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DeliverRequire(vbeln),
      ),
    );
  }

  ///发货需求编辑界面
  static goDeliverEdit(BuildContext context, String vbeln) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DeliverEdit(vbeln),
      ),
    );
  }

  ///发货跟踪
  static goDeliveryTracking(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DeliveryTracking(),
      ),
    );
  }

  ///开票情况
  static goSaleMessage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SaleMessage(),
      ),
    );
  }

  ///未开票明细
  static goNoSaleDetails(BuildContext context, {kunnr, fhmonth, ticketnum}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SaleDetails(kunnr: kunnr, fhmonth: fhmonth,),
      ),
    );
  }

  ///已开票明细
  static goSaleDetails(BuildContext context, {kunnr, fhmonth, ticketnum}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SaleDetails(ticketnum: ticketnum),
      ),
    );
  }

  ///货款回笼
  static goPaymentWithdrawal(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentWithdrawal(),
      ),
    );
  }

  ///货款回笼明细
  static goPaymentDetails(BuildContext context, sDate, eDate, kunnr) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentDetails(sDate, eDate, kunnr),
      ),
    );
  }

  /*///一次发泡
  ///生产线列表
  static goFirstBubbleList(BuildContext context, String mid) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FirstBubbleList(mid),
      ),
    );
  }

  ///养生袋清单
  static goHealthBagList(BuildContext context) {
    Navigator.pushNamed(context, HealthBagList.sName);
  }

  ///二次发泡清单
  static goSecondBubbleList(BuildContext context) {
    Navigator.pushNamed(context, SecondBubbleList.sName);
  }

  ///预压罐清单
  static goPrepressureTankList(BuildContext context) {
    Navigator.pushNamed(context, PrepressureTankList.sName);
  }

  ///打包密度清单
  static goPackingDensityList(BuildContext context) {
    Navigator.pushNamed(context, PackingDensityList.sName);
  }*/

  ///通用
  ///修改密码
  static goUpdatePwd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdatePwd(),
      ),
    );

  }

  ///设置参数
  static goParamSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParamSetting(),
      ),
    );

  }

  ///问题反馈
  static goQuestionSubmission(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(
          builder: (context)=> QuestionSubmission(),
        )
    );
  }

  ///版本更新
  static goVersionUpdate(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(
          builder: (context)=> VersionUpdate(),
        ));
  }

//  static NavigatorRouter(BuildContext context,Widget widget) {
//    return Navigator.push(context, CupertinoPageRoute(builder: (context) => widget));
//  }


//发出情况明细-成交明细
    static goCloseingDetail(BuildContext context,String kunnr,String date ){
     Navigator.of(context).push(
           MaterialPageRoute(
          builder: (context) => ClosingDetail(kunnr: kunnr,date: date)

           ));
    }


//应收货款明细
    static goTradeDetailsDetail(BuildContext context,String custormer,String kunnr ){
     Navigator.of(context).push(
           MaterialPageRoute(
          builder: (context) => TradeDetails(custormer: custormer,kunnr: kunnr,)

           ));
    }


//物流跟踪明细
    static goLogisticsDetailsDetail(BuildContext context,String order_no){
     Navigator.of(context).push(
           MaterialPageRoute(
          builder: (context) => LogisticsDetail(order_no: order_no)

           ));
    }
}