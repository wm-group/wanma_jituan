
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
        },
        {
            "title": "发货需求",
            "functionName": "goDeliverDemand",
            "id": 10
        },
        {
            "title": "市场调研",
            "functionName": "goMarketResearch",
            "id": 11
        },
        {
            "title": "物料勾选",
            "functionName": "goMaterialSelection",
            "id": 12
        }
    ],
    "msg": "成功",
    "code": 0
}
  ''';

  static final String tempMaterialData = '''
  [{"wlzms":"硅烷","flag":"0","wlz":"1200007245","wlmc":"101C2"},{"wlzms":"硅烷","flag":"0","wlz":"1200006543","wlmc":"101DL"},{"wlzms":"硅烷","flag":"0","wlz":"1200013751","wlmc":"101G"},{"wlzms":"硅烷","flag":"0","wlz":"1200004237","wlmc":"A101A"},{"wlzms":"硅烷","flag":"0","wlz":"1200004250","wlmc":"A101AK"},{"wlzms":"硅烷","flag":"0","wlz":"1200004220","wlmc":"A101B"},{"wlzms":"硅烷","flag":"0","wlz":"1200004222","wlmc":"A101BX"},{"wlzms":"硅烷","flag":"0","wlz":"1200004223","wlmc":"A101C"},{"wlzms":"硅烷","flag":"0","wlz":"1200011206","wlmc":"A101CM"},{"wlzms":"硅烷","flag":"0","wlz":"1200004251","wlmc":"A101E"},{"wlzms":"硅烷","flag":"0","wlz":"1200004226","wlmc":"A101H"},{"wlzms":"硅烷","flag":"0","wlz":"1200004224","wlmc":"A101K"},{"wlzms":"硅烷","flag":"0","wlz":"1200004221","wlmc":"A101KX"},{"wlzms":"硅烷","flag":"0","wlz":"1200004693","wlmc":"A101T"},{"wlzms":"硅烷","flag":"0","wlz":"1200004225","wlmc":"A101Z"},{"wlzms":"硅烷","flag":"0","wlz":"1200004228","wlmc":"A201A"},{"wlzms":"硅烷","flag":"0","wlz":"1200004234","wlmc":"A201A2"},{"wlzms":"硅烷","flag":"0","wlz":"1200004229","wlmc":"A201B"},{"wlzms":"硅烷","flag":"0","wlz":"1200004235","wlmc":"A201B2"},{"wlzms":"硅烷","flag":"0","wlz":"1200004230","wlmc":"A201C"},{"wlzms":"硅烷","flag":"0","wlz":"1200004236","wlmc":"A201C2"},{"wlzms":"硅烷","flag":"0","wlz":"1200011202","wlmc":"A201C2M"},{"wlzms":"硅烷","flag":"0","wlz":"1200013106","wlmc":"A201H2"},{"wlzms":"硅烷","flag":"0","wlz":"1200004231","wlmc":"A201K"},{"wlzms":"硅烷","flag":"0","wlz":"1200004233","wlmc":"A201W"},{"wlzms":"硅烷","flag":"0","wlz":"1200004232","wlmc":"A201Z"},{"wlzms":"硅烷","flag":"0","wlz":"1200004227","wlmc":"AEZ-90"},{"wlzms":"硅烷","flag":"0","wlz":"1200010254","wlmc":"AWMA101本"},{"wlzms":"硅烷","flag":"0","wlz":"1200011535","wlmc":"AWMA101 本（进加）"},{"wlzms":"硅烷","flag":"0","wlz":"1200010255","wlmc":"AWMA101黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200011536","wlmc":"AWMA101 黑（进加）"},{"wlzms":"硅烷","flag":"0","wlz":"1200002165","wlmc":"B101AK_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200007240","wlmc":"B101AT"},{"wlzms":"硅烷","flag":"0","wlz":"1200000931","wlmc":"B101B_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000932","wlmc":"B101C_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200011205","wlmc":"B101CM_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200010764","wlmc":"B101CP"},{"wlzms":"硅烷","flag":"0","wlz":"1200000933","wlmc":"B101H_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000934","wlmc":"B101K_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200009549","wlmc":"B101KH"},{"wlzms":"硅烷","flag":"0","wlz":"1200010980","wlmc":"B101KH-UV"},{"wlzms":"硅烷","flag":"0","wlz":"1200000935","wlmc":"B101T_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000936","wlmc":"B101Z_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000937","wlmc":"B201B_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200000938","wlmc":"B201C_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200001918","wlmc":"B201C2_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200011203","wlmc":"B201C2M_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200013108","wlmc":"B201H2"},{"wlzms":"硅烷","flag":"0","wlz":"1200000939","wlmc":"B201K_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200009550","wlmc":"B201KH"},{"wlzms":"硅烷","flag":"0","wlz":"1200000940","wlmc":"B201T_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200004252","wlmc":"B201W"},{"wlzms":"硅烷","flag":"0","wlz":"1200000941","wlmc":"B201Z_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200000952","wlmc":"BY101_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000966","wlmc":"BY201_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200005679","wlmc":"D101A"},{"wlzms":"硅烷","flag":"0","wlz":"1200011698","wlmc":"D101AG"},{"wlzms":"硅烷","flag":"0","wlz":"1200005684","wlmc":"D101AK"},{"wlzms":"硅烷","flag":"0","wlz":"1200007239","wlmc":"D101AT"},{"wlzms":"硅烷","flag":"0","wlz":"1200005682","wlmc":"D101B"},{"wlzms":"硅烷","flag":"0","wlz":"1200005681","wlmc":"D101BX"},{"wlzms":"硅烷","flag":"0","wlz":"1200005683","wlmc":"D101C"},{"wlzms":"硅烷","flag":"0","wlz":"1200007246","wlmc":"D101C2"},{"wlzms":"硅烷","flag":"0","wlz":"1200005693","wlmc":"D101E"},{"wlzms":"硅烷","flag":"0","wlz":"1200012982","wlmc":"D101ER"},{"wlzms":"硅烷","flag":"0","wlz":"1200013752","wlmc":"D101G"},{"wlzms":"硅烷","flag":"0","wlz":"1200005692","wlmc":"D101H"},{"wlzms":"硅烷","flag":"0","wlz":"1200005652","wlmc":"D101K"},{"wlzms":"硅烷","flag":"0","wlz":"1200009547","wlmc":"D101KH"},{"wlzms":"硅烷","flag":"0","wlz":"1200010979","wlmc":"D101KH-UV"},{"wlzms":"硅烷","flag":"0","wlz":"1200005680","wlmc":"D101KX"},{"wlzms":"硅烷","flag":"0","wlz":"1200007248","wlmc":"D101SC"},{"wlzms":"硅烷","flag":"0","wlz":"1200005704","wlmc":"D101T"},{"wlzms":"硅烷","flag":"0","wlz":"1200005653","wlmc":"D101Z"},{"wlzms":"硅烷","flag":"0","wlz":"1200005685","wlmc":"D201A"},{"wlzms":"硅烷","flag":"0","wlz":"1200005689","wlmc":"D201A2"},{"wlzms":"硅烷","flag":"0","wlz":"1200009269","wlmc":"D201AG"},{"wlzms":"硅烷","flag":"0","wlz":"1200005688","wlmc":"D201AK"},{"wlzms":"硅烷","flag":"0","wlz":"1200005686","wlmc":"D201B"},{"wlzms":"硅烷","flag":"0","wlz":"1200005690","wlmc":"D201B2"},{"wlzms":"硅烷","flag":"0","wlz":"1200005687","wlmc":"D201C"},{"wlzms":"硅烷","flag":"0","wlz":"1200007249","wlmc":"D201C1"},{"wlzms":"硅烷","flag":"0","wlz":"1200005691","wlmc":"D201C2"},{"wlzms":"硅烷","flag":"0","wlz":"1200005695","wlmc":"D201E"},{"wlzms":"硅烷","flag":"0","wlz":"1200005696","wlmc":"D201H"},{"wlzms":"硅烷","flag":"0","wlz":"1200013107","wlmc":"D201H2"},{"wlzms":"硅烷","flag":"0","wlz":"1200005654","wlmc":"D201K"},{"wlzms":"硅烷","flag":"0","wlz":"1200012787","wlmc":"D201KD"},{"wlzms":"硅烷","flag":"0","wlz":"1200009548","wlmc":"D201KH"},{"wlzms":"硅烷","flag":"0","wlz":"1200007695","wlmc":"D201SC"},{"wlzms":"硅烷","flag":"0","wlz":"1200005705","wlmc":"D201T"},{"wlzms":"硅烷","flag":"0","wlz":"1200005706","wlmc":"D201T2"},{"wlzms":"硅烷","flag":"0","wlz":"1200005697","wlmc":"D201W"},{"wlzms":"硅烷","flag":"0","wlz":"1200005655","wlmc":"D201Z"},{"wlzms":"硅烷","flag":"0","wlz":"1200005694","wlmc":"DEZ-90"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200008088","wlmc":"HFDB-0586BKS"},{"wlzms":"硅烷","flag":"0","wlz":"1200005728","wlmc":"HYJZDG-90"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200002053","wlmc":"PSD_WMP-0001_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200002054","wlmc":"PSD_WMP-00012_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200002056","wlmc":"PSD_WMP-00013_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200002055","wlmc":"PSD_WMP-00019_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200001996","wlmc":"PYJBJ-10kV_WMP-1101_B_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200008306","wlmc":"PYJBJ-10kV_WMP-1101_C_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200001997","wlmc":"PYJBJ-10kV_WMP-11019B_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200001998","wlmc":"PYJBJ-35kV_WMP-1103_B_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200009046","wlmc":"PYJBJ-35KV_WMP-1103_BH_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200008337","wlmc":"PYJBJ-35KV_WMP-1103_C_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200001999","wlmc":"PYJBJ-35kV_WMP-11039B_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200001993","wlmc":"PYJD-10kV_WMP-1001_K_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200001990","wlmc":"PYJD-10kV_WMP-1001_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200001992","wlmc":"PYJD-10kV_WMP-10011_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200001991","wlmc":"PYJD-10kV_WMP-10019_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200009057","wlmc":"PYJD-35KV_WMP-1003_H_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200002191","wlmc":"PYJD-35kV_WMP-1003_K_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200002248","wlmc":"PYJD-35kV_WMP-1003_W_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200001994","wlmc":"PYJD-35kV_WMP-1003_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200001995","wlmc":"PYJD-35kV_WMP-10039_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200009999","wlmc":"PYJGD"},{"wlzms":"硅烷","flag":"0","wlz":"1200010000","wlmc":"  PYJGD_A料"},{"wlzms":"硅烷","flag":"0","wlz":"1200010001","wlmc":"  PYJGD_B料"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200005498","wlmc":"PYJJ-10kV_WMP-11019_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200001868","wlmc":"PYJJ-110_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200002249","wlmc":"PYJJ-35kV_WMP-1103_W_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200002000","wlmc":"PYJJ-35kV_WMP-1103_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200007494","wlmc":"PYJJ-35KV_WMP-11039_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200002001","wlmc":"PYJYBJ-10kV_WMP-1101_Y_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200002002","wlmc":"PYJYBJ-35kV_WMP-1103_Y_黑"},{"wlzms":"交联","flag":"0","wlz":"1200000930","wlmc":"TR-YJ-10_本"},{"wlzms":"交联","flag":"1","wlz":"1200000929","wlmc":"TR-YJ-35_本"},{"wlzms":"交联","flag":"1","wlz":"1200008245","wlmc":"TR-YJG-10_本"},{"wlzms":"交联","flag":"1","wlz":"1200005758","wlmc":"TR-YJW-35"},{"wlzms":"交联","flag":"1","wlz":"1200008079","wlmc":"TR-YJWG-10_黑"},{"wlzms":"屏蔽料","flag":"0","wlz":"1200009594","wlmc":"WMP-1011_S_黑"},{"wlzms":"交联","flag":"1","wlz":"1200014251","wlmc":"WMY-4201 EHV"},{"wlzms":"超高压","flag":"1","wlz":"1200002003","wlmc":"WMY-4201S_本(YJ-66)"},{"wlzms":"超高压","flag":"1","wlz":"1200000926","wlmc":"WMY-4201SC_本(YJ-110)"},{"wlzms":"交联","flag":"1","wlz":"1200000928","wlmc":"WM-YJ-10_本"},{"wlzms":"交联","flag":"1","wlz":"1200000927","wlmc":"YJ-10_本"},{"wlzms":"交联","flag":"1","wlz":"1200007635","wlmc":"YJ-10-HD"},{"wlzms":"交联","flag":"1","wlz":"1200009053","wlmc":"YJ-10（进加）_本"},{"wlzms":"交联","flag":"1","wlz":"1200000925","wlmc":"YJ-35_本"},{"wlzms":"交联","flag":"1","wlz":"1200000924","wlmc":"YJ-35(出口)_本"},{"wlzms":"交联","flag":"1","wlz":"1200009052","wlmc":"YJ-35(进加)_本"},{"wlzms":"交联","flag":"0","wlz":"1200006164","wlmc":"YJ-35-HD_本"},{"wlzms":"交联","flag":"1","wlz":"1200000923","wlmc":"YJ-DC_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200007247","wlmc":"YJG-10_101SC_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000942","wlmc":"YJG-3_101A_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200002157","wlmc":"YJG-3_101AK_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000943","wlmc":"YJG-3_101B_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200001784","wlmc":"YJG-3_101BX_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000944","wlmc":"YJG-3_101C_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200011204","wlmc":"YJG-3_101CM_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200001817","wlmc":"YJG-3_101E_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200012981","wlmc":"YJG-3_101ER_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000945","wlmc":"YJG-3_101H_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000946","wlmc":"YJG-3_101K_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000953","wlmc":"YJG-3_101KG_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200008160","wlmc":"YJG-3_101KH_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200010978","wlmc":"YJG-3_101KH-UV"},{"wlzms":"硅烷","flag":"0","wlz":"1200004213","wlmc":"YJG-3_101KX_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200014245","wlmc":"YJG-3_101QA_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200007696","wlmc":"YJG-3_101SC_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000948","wlmc":"YJG-3_101Z_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000949","wlmc":"YJG-3_EZ-90_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200000950","wlmc":"YJG-3_S-241_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200010252","wlmc":"YJG-3_WMA101本"},{"wlzms":"硅烷","flag":"0","wlz":"1200011547","wlmc":"YJG-3_WMA101 本（进加）"},{"wlzms":"硅烷","flag":"0","wlz":"1200000947","wlmc":"YJG-3_X-90_本"},{"wlzms":"硅烷一步法","flag":"0","wlz":"1200000951","wlmc":"YJG-3_Y101_本"},{"wlzms":"硅烷一步法","flag":"0","wlz":"1200002218","wlmc":"YJG-3_Y101A 本"},{"wlzms":"硅烷","flag":"0","wlz":"1200008196","wlmc":"YJG-3_Y101A 黑"},{"wlzms":"硅烷一步法","flag":"0","wlz":"1200008665","wlmc":"YJG-3_Y101C_本"},{"wlzms":"硅烷一步法","flag":"0","wlz":"1200001785","wlmc":"YJG-3_Y101K_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200011699","wlmc":"YJG-3 101AG"},{"wlzms":"硅烷","flag":"0","wlz":"1200007238","wlmc":"YJG-3 101AT"},{"wlzms":"交联","flag":"0","wlz":"1200001530","wlmc":"YJ-HVDC-320M_白 直流料"},{"wlzms":"超高压","flag":"1","wlz":"1200009440","wlmc":"YJ-HVDC-500M"},{"wlzms":"交联","flag":"1","wlz":"1200000922","wlmc":"YJW-10_黑"},{"wlzms":"交联","flag":"0","wlz":"1200000921","wlmc":"YJW-35_黑"},{"wlzms":"交联","flag":"1","wlz":"1200000920","wlmc":"YJW-35-UV_黑"},{"wlzms":"交联","flag":"1","wlz":"1200000920","wlmc":"YJW-35-UV_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200000955","wlmc":"YJWG-10_201A_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200002189","wlmc":"YJWG-10_201A2_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200008967","wlmc":"YJWG-10_201AG_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200000956","wlmc":"YJWG-10_201B_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200000957","wlmc":"YJWG-10_201B2_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200000958","wlmc":"YJWG-10_201C_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200007250","wlmc":"YJWG-10_201C1_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200000959","wlmc":"YJWG-10_201C2_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200011201","wlmc":"YJWG-10_201C2M_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200013105","wlmc":"YJWG-10_201H2_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200000960","wlmc":"YJWG-10_201K_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200012766","wlmc":"YJWG-10_201KD_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200008161","wlmc":"YJWG-10_201KH_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200014246","wlmc":"YJWG-10_201QA_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200007697","wlmc":"YJWG-10_201SC"},{"wlzms":"硅烷","flag":"0","wlz":"1200000961","wlmc":"YJWG-10_201T_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200000954","wlmc":"YJWG-10_201T2_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200000962","wlmc":"YJWG-10_201W_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200000963","wlmc":"YJWG-10_201Z_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200010253","wlmc":"YJWG-10_WMA101黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200011548","wlmc":"YJWG-10_WMA101 黑（进加）"},{"wlzms":"硅烷一步法","flag":"0","wlz":"1200000964","wlmc":"YJWG-10_Y201_黑"},{"wlzms":"硅烷一步法","flag":"0","wlz":"1200000965","wlmc":"YJWG-10_Y201_灰"},{"wlzms":"硅烷一步法","flag":"0","wlz":"1200008077","wlmc":"YJWG-10_Y201C_黑"},{"wlzms":"硅烷一步法","flag":"0","wlz":"1200001786","wlmc":"YJWG-10_Y201K_黑"},{"wlzms":"硅烷","flag":"0","wlz":"1200001648","wlmc":"YJZDG-105_白"},{"wlzms":"硅烷","flag":"0","wlz":"1200001647","wlmc":"YJZDG-105_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200001531","wlmc":"YJZDG-125A_本"},{"wlzms":"硅烷","flag":"0","wlz":"1200001532","wlmc":"YJZDG-125B_白"},{"wlzms":"超高压","flag":"1","wlz":"1200002004","wlmc":"重复 待定"}]
  ''';

  static final String tempData = '''
  [{"customer":"尚纬股份","orderdate":"2020-01-15","handdate":"2020-02-02","status":"未发货","vbeln":"0015046674"},
  {"customer":"四川新蓉ffefgdfasgtt","orderdate":"2019-12-25","handdate":"2019-12-30","status":"部分发货","vbeln":"0010035654"},
  {"customer":"四川新蓉","orderdate":"2020-02-11","handdate":"2020-02-14","status":"未发货","vbeln":"0015046801"},
  {"customer":"金杯塔牌","orderdate":"2020-01-16","handdate":"2020-01-21","status":"部分发货","vbeln":"0015046725"},
  {"customer":"四川省新都美河","orderdate":"2020-02-08","handdate":"2020-02-13","status":"未发货","vbeln":"0010036178"},
  {"customer":"尚纬股份","orderdate":"2020-01-15","handdate":"2020-02-02","status":"未发货","vbeln":"0015046674"},{"customer":"四川新蓉","orderdate":"2019-12-25","handdate":"2019-12-30","status":"部分发货","vbeln":"0010035654"},{"customer":"四川新蓉","orderdate":"2020-02-11","handdate":"2020-02-14","status":"未发货","vbeln":"0015046801"},{"customer":"金杯塔牌","orderdate":"2020-01-16","handdate":"2020-01-21","status":"部分发货","vbeln":"0015046725"},{"customer":"四川省新都美河","orderdate":"2020-02-08","handdate":"2020-02-13","status":"未发货","vbeln":"0010036178"},
  {"customer":"尚纬股份","orderdate":"2020-01-15","handdate":"2020-02-02","status":"未发货","vbeln":"0015046674"},{"customer":"四川新蓉","orderdate":"2019-12-25","handdate":"2019-12-30","status":"部分发货","vbeln":"0010035654"},{"customer":"四川新蓉","orderdate":"2020-02-11","handdate":"2020-02-14","status":"未发货","vbeln":"0015046801"},{"customer":"金杯塔牌","orderdate":"2020-01-16","handdate":"2020-01-21","status":"部分发货","vbeln":"0015046725"},{"customer":"四川省新都美河","orderdate":"2020-02-08","handdate":"2020-02-13","status":"未发货","vbeln":"0010036178"},
  {"customer":"尚纬股份","orderdate":"2020-01-15","handdate":"2020-02-02","status":"未发货","vbeln":"0015046674"},{"customer":"四川新蓉","orderdate":"2019-12-25","handdate":"2019-12-30","status":"部分发货","vbeln":"0010035654"},{"customer":"四川新蓉","orderdate":"2020-02-11","handdate":"2020-02-14","status":"未发货","vbeln":"0015046801"},{"customer":"金杯塔牌","orderdate":"2020-01-16","handdate":"2020-01-21","status":"部分发货","vbeln":"0015046725"},{"customer":"四川省新都美河","orderdate":"2020-02-08","handdate":"2020-02-13","status":"未发货","vbeln":"0010036178"}]
  ''';
}