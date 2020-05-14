import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/tl_dao.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';
import 'package:date_format/date_format.dart';
import 'dart:async';

import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class TLLineDetail extends StatelessWidget {

  final String lineNo;
  final String lineName;

  TLLineDetail(this.lineNo, this.lineName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(lineName),
      ),
      body: LineDetailBody(lineNo, lineName),
    );
  }
}

class LineDetailBody extends StatefulWidget {

  final String lineNo;
  final String lineName;
  LineDetailBody(this.lineNo, this.lineName);

  @override
  _LineDetailBodyState createState() => _LineDetailBodyState();
}

class _LineDetailBodyState extends State<LineDetailBody> {

  var _data;
  Timer timer;
  List keyList = ["客户订单", "操作者", "盘号", "主机速度(R/min)",
    "前牵速度(R/min)", "后牵速度(R/min)", "内层速度(R/min)", "冷态外径",
    "单盘米数", "外径设定(mm)", "热态外径(mm)", "张力系数",
    "张力显示(N)", "线速度(M/min)", "螺膛压力(Mpa)", "电容显示(PF/m)" ,"电容设定(PF/m)","产量(m)"];
  List valueList = ["kunnr", "operate_user", "pan_no", "main_speed",
    "fore_speed", "back_speed", "inner_speed", "cool_diameter",
    "pan_meter", "hot_diameter_set", "hot_diameter", "force_set",
    "force_dis", "line_speed", "pressure", "prod_amount" ,"elec","elec_set"];

  bool isLoading = true;

  initState() {
    super.initState();
    _getTLLineDetail();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _getTLLineDetail();
    });
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _getTLLineDetail() async {
    var _now = DateTime.now();
    var dateStr = formatDate(_now, [yyyy, '-', mm, '-', dd, '-', HH, '-', nn, '-', ss]);
    _data = await TLDao.getTLLineDetail(widget.lineNo, dateStr);
    if(!mounted) {
      return;
    }
    setState(() {
      isLoading = false;
    });
  }

  _getRow(title, content) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
              Text('$content'),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  _getColumnWidgets(Map tempMap) {
    List<Widget> columnList = List();
    for(int i=0;i<keyList.length;i++) {
      if(tempMap[valueList[i]] == null) {
        tempMap[valueList[i]] = '待建设';
      }
      columnList.add(_getRow(keyList[i], tempMap[valueList[i]]));
    }
    return columnList;
  }

  @override
  Widget build(BuildContext context) {
    var dataMap;
    if(_data != null) {
      dataMap = _data[0];
    }else {
      dataMap = Map();
      for(var str in valueList) {
        dataMap[str] = '待建设';
      }
    }
    if(isLoading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }else {
      return Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.lineName, style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor),),
                  Text('${dataMap['business_date']}-${dataMap['business_time']}', style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor),),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView(
                children: <Widget>[
                  Card(
                    elevation: 15.0,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Column(
                      children: _getColumnWidgets(dataMap),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      _getTLLineDetail();
                    },
                    child: Text('刷            新', style: WMConstant.normalTextWhite,),
                  ),
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    onPressed: () {
                      NavigatorUtils.goTLLineCurve(context, widget.lineNo);
                    },
                    child: Text('显示线性图', style: WMConstant.normalTextWhite,),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

