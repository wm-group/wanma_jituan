import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanma_jituan/page/Gfz/gfz_home_page.dart';
import 'package:wanma_jituan/page/app.dart';
import 'package:wanma_jituan/page/common/param_setting.dart';
import 'package:wanma_jituan/page/common/question_submission.dart';
import 'package:wanma_jituan/page/common/update_pwd.dart';
import 'package:wanma_jituan/page/common/version_update.dart';
import 'package:wanma_jituan/page/gfz/reportform/material_storage/storage_form.dart';
import 'package:wanma_jituan/page/login_page.dart';
import 'package:wanma_jituan/page/gfz/industry/exception_query/exception_query.dart';
import 'package:wanma_jituan/page/gfz/industry/exception_query/exception_query_detail.dart';
import 'package:wanma_jituan/page/gfz/industry/production_line/production_line.dart';


import 'package:wanma_jituan/page/gfz/business/base_price/base_price.dart';//基准价
import 'package:wanma_jituan/page/gfz/business/deliver_demand/deliver_demand.dart';
import 'package:wanma_jituan/page/gfz/business/deliver_demand/deliver_history.dart';
import 'package:wanma_jituan/page/gfz/business/delivery_tracking/delivery_tracking.dart';
import 'package:wanma_jituan/page/gfz/business/issue_situation/closing_details.dart';//发出明细
import 'package:wanma_jituan/page/gfz/business/issue_situation/issue_situation.dart';//发出情况
import 'package:wanma_jituan/page/gfz/business/logistics_tracking/logistics_detail.dart';//物流明细
import 'package:wanma_jituan/page/gfz/business/logistics_tracking/logistics_tracking.dart';//物流跟踪
import 'package:wanma_jituan/page/gfz/business/market_research/market_detail.dart';//市场调研明细
import 'package:wanma_jituan/page/gfz/business/market_research/market_research.dart';//市场调研
import 'package:wanma_jituan/page/gfz/business/material_selection/material_selection.dart';
import 'package:wanma_jituan/page/gfz/business/order_status/deliver_details.dart';
import 'package:wanma_jituan/page/gfz/business/order_status/deliver_edit.dart';
import 'package:wanma_jituan/page/gfz/business/order_status/deliver_require.dart';
import 'package:wanma_jituan/page/gfz/business/order_status/order_details.dart';
import 'package:wanma_jituan/page/gfz/business/order_status/order_goods_follow.dart';
import 'package:wanma_jituan/page/gfz/business/order_status/order_status.dart';
import 'package:wanma_jituan/page/gfz/business/payment_withdrawal/payment_details.dart';
import 'package:wanma_jituan/page/gfz/business/payment_withdrawal/payment_withdrawal.dart';
import 'package:wanma_jituan/page/gfz/business/sale_message/sale_details.dart';
import 'package:wanma_jituan/page/gfz/business/sale_message/sale_message.dart';
import 'package:wanma_jituan/page/gfz/business/target_situation/target_situation.dart';//目标情况
import 'package:wanma_jituan/page/gfz/business/trade_receivable/trade_details.dart';
import 'package:wanma_jituan/page/gfz/business/trade_receivable/trade_receivable.dart';//应收货款
import 'package:wanma_jituan/page/gfz/industry/line_history/line_history.dart';
import 'package:wanma_jituan/page/gfz/industry/lines_list/line_detail.dart';
import 'package:wanma_jituan/page/gfz/industry/lines_list/line_list.dart';
import 'package:wanma_jituan/page/gfz/industry/lines_list/lines_list.dart';
//报表
import 'package:wanma_jituan/page/gfz/reportform/goods_registration/goods_registration.dart';
import 'package:wanma_jituan/page/gfz/reportform/material_storage/material_storage.dart'; 
import 'package:wanma_jituan/page/gfz/reportform/goods_storage_list/goods_storage_list.dart';
import 'package:wanma_jituan/page/gfz/reportform/material_storage_list/material_storage_list.dart';
import 'package:wanma_jituan/page/tl/industry/tl_exception_query/tl_exception_detail.dart';
import 'package:wanma_jituan/page/tl/industry/tl_exception_query/tl_exception_query.dart';
import 'package:wanma_jituan/page/tl/industry/tl_inventory/TLInventory.dart';
import 'package:wanma_jituan/page/tl/industry/tl_list/tl_line_curve.dart';
import 'package:wanma_jituan/page/tl/industry/tl_list/tl_line_detail.dart';
import 'package:wanma_jituan/page/tl/industry/tl_list/tl_list.dart';
import 'package:wanma_jituan/page/tl/industry/tl_month_query/tl_month_query.dart';
import 'package:wanma_jituan/page/tl/tl_home_page.dart';
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
  static goIssueSituation(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => IssueSituation(),
      ),
    );
  }

  ///目标情况
  static goTargetSituation(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => TargetSituation(),
      ),
    );
  }

  ///基准价
  static goBasePrice(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => BasePrice(),
      ),
    );
  }

  ///应收货款
  static goTradeReceivable(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => TradeReceivable(),
      ),
    );
  }

  ///物流跟踪
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

  ///历史发货需求
  static goDeliverHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DeliverHistory(),
      ),
    );
  }

  ///发货需求最终明细
  static goDeliverDetails(BuildContext context, String vbeln) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DeliverDetails(vbeln),
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

  ///物料勾选
  static goMaterialSelection(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MaterialSelection(),
      ),
    );
  }

  ///发货需求
  static goDeliverDemand(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DeliverDemand(),
      ),
    );
  }

  //市场调研
  static goMarketResearch(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MarketResearch(),
      ),
    );
  }

  //市场调研明细
  static goMarketetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MarketDetail(),
      ),
    );
  }

  ///高分子工业4.0
  ///生产线列表
  static goLinesList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LinesList(),
      ),
    );
  }

  ///生产线列表
  static goLineList(BuildContext context, String department) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LineList(department: department),
      ),
    );
  }

  ///生产线详细信息
  static goLineDetail(BuildContext context, String lineNo, String lineName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LineDetail(lineNo: lineNo, lineName: lineName),
      ),
    );
  }

  ///历史运行曲线
  static goLineHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LineHistory(),
      ),
    );
  }

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
    static goLogisticsDetailsDetail(BuildContext context,String orderNo){
     Navigator.of(context).push(
           MaterialPageRoute(
          builder: (context) => LogisticsDetail(order_no: orderNo)

           ));
    }


//工业4.0
//异常查询
  static goExceptionQuery(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExceptionQuery(),
      ),
    );
  }
  //异常查询明细
  static goExceptionQueryDetail(BuildContext context,lineNo,lineDate) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExceptionQueryDetail(lineNo:lineNo ,lineDate: lineDate),
      ),
    );
  }
//生产线运行日志
static goProductionLine(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductionLine(),
      ),
    );
  }

  //报表
  //成品发货
  static goGoodsRegistration(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GoodsRegistration(),
      ),
    );
  }

  //原材料入库
  static goMaterialStorage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MaterialStorage(),
      ),
    );
  }

  static goStorageForm(BuildContext context, wareId, wareName, sk, inoutId, purpose) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StorageForm(wareId, wareName, sk, inoutId, purpose),
      ),
    );
  }
  //成品发货列表
  static goGoodsStorageList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GoodsStorageList(),
      ),
    );
  }
//原材料发货列表
  static goMaterialStorageList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MaterialStorageList(),
      ),
    );
  }

  ///特缆
  ///主页
  static goHomeTL(BuildContext context, String mid) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TLHomePage(mid),
      ),
    );
  }

  ///芯线生产量列表
  static goTLList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TLList(),
      ),
    );
  }

  //芯线详情页
  static goTLLineDetails(BuildContext context, lineNo, lineName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TLLineDetail(lineNo, lineName),
      ),
    );
  }

  //芯线详情曲线
  static goTLLineCurve(BuildContext context, lineNo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TLLineCurve(lineNo),
      ),
    );
  }

  ///芯线月产量查询
  static goTLMonthQuery(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TLMonthQuery(),
      ),
    );
  }

  ///芯线异常查询
  static goTLExceptionQuery(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TLExceptionQuery(),
      ),
    );
  }

  ///芯线异常查询明细
  static goTLExceptionDetail(BuildContext context, lineNo, startDate, endDate) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TLExceptionDetail(lineNo, startDate, endDate),
      ),
    );
  }

  ///半成品盘点
  static goTLInventory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TLInventory(),
      ),
    );
  }
  
}