
abstract class JsonString {
  static final String homeData ='''
  {
    "result": [
        {
            "title": "材料板块",
            "id": 1
        }
    ],
    "msg": "成功",
    "code": 0
}
  ''';

  static final String gfzOrderData ='''
  {
    "result": [
        {
            "title": "订单状态",
            "functionName": "goOrderStatus",
            "id": 1
        },
        {
            "title": "发货跟踪",
            "functionName": "goDeliveryTracking",
            "id": 2
        },
        {
            "title": "开票情况",
            "functionName": "goSaleMessage",
            "id": 3
        },
        {
            "title": "货款回笼",
            "functionName": "goPaymentWithdrawal",
            "id": 4
        },
        {
            "title": "发出情况",
            "functionName": "goIssueSituation",
            "id": 5
        },
        {
            "title": "目标情况",
            "functionName": "goTargetSituation",
            "id": 6
        },
        {
            "title": "基准价",
            "functionName": "goBasePrice",
            "id": 7
        },
        {
            "title": "应收货款",
            "functionName": "goTradeReceivable",
            "id": 8
        },
         {
            "title": "物流跟踪",
            "functionName": "goLogisticsTracking",
            "id": 9
        }
    ],
    "msg": "成功",
    "code": 0
}
  ''';

  static final String tempData = '''
  [{"customer":"尚纬股份","orderdate":"2020-01-15","handdate":"2020-02-02","status":"未发货","vbeln":"0015046674"},
  {"customer":"四川新蓉","orderdate":"2019-12-25","handdate":"2019-12-30","status":"部分发货","vbeln":"0010035654"},
  {"customer":"四川新蓉","orderdate":"2020-02-11","handdate":"2020-02-14","status":"未发货","vbeln":"0015046801"},
  {"customer":"金杯塔牌","orderdate":"2020-01-16","handdate":"2020-01-21","status":"部分发货","vbeln":"0015046725"},
  {"customer":"四川省新都美河","orderdate":"2020-02-08","handdate":"2020-02-13","status":"未发货","vbeln":"0010036178"},
  {"customer":"尚纬股份","orderdate":"2020-01-15","handdate":"2020-02-02","status":"未发货","vbeln":"0015046674"},{"customer":"四川新蓉","orderdate":"2019-12-25","handdate":"2019-12-30","status":"部分发货","vbeln":"0010035654"},{"customer":"四川新蓉","orderdate":"2020-02-11","handdate":"2020-02-14","status":"未发货","vbeln":"0015046801"},{"customer":"金杯塔牌","orderdate":"2020-01-16","handdate":"2020-01-21","status":"部分发货","vbeln":"0015046725"},{"customer":"四川省新都美河","orderdate":"2020-02-08","handdate":"2020-02-13","status":"未发货","vbeln":"0010036178"},
  {"customer":"尚纬股份","orderdate":"2020-01-15","handdate":"2020-02-02","status":"未发货","vbeln":"0015046674"},{"customer":"四川新蓉","orderdate":"2019-12-25","handdate":"2019-12-30","status":"部分发货","vbeln":"0010035654"},{"customer":"四川新蓉","orderdate":"2020-02-11","handdate":"2020-02-14","status":"未发货","vbeln":"0015046801"},{"customer":"金杯塔牌","orderdate":"2020-01-16","handdate":"2020-01-21","status":"部分发货","vbeln":"0015046725"},{"customer":"四川省新都美河","orderdate":"2020-02-08","handdate":"2020-02-13","status":"未发货","vbeln":"0010036178"},
  {"customer":"尚纬股份","orderdate":"2020-01-15","handdate":"2020-02-02","status":"未发货","vbeln":"0015046674"},{"customer":"四川新蓉","orderdate":"2019-12-25","handdate":"2019-12-30","status":"部分发货","vbeln":"0010035654"},{"customer":"四川新蓉","orderdate":"2020-02-11","handdate":"2020-02-14","status":"未发货","vbeln":"0015046801"},{"customer":"金杯塔牌","orderdate":"2020-01-16","handdate":"2020-01-21","status":"部分发货","vbeln":"0015046725"},{"customer":"四川省新都美河","orderdate":"2020-02-08","handdate":"2020-02-13","status":"未发货","vbeln":"0010036178"}]
  ''';
}