import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fl_chart/fl_chart.dart';

class LineHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('历史运行曲线'),
      ),
      body: LineHistoryBody(),
    );
  }
}

class LineHistoryBody extends StatefulWidget {
  @override
  _LineHistoryBodyState createState() => _LineHistoryBodyState();
}

class _LineHistoryBodyState extends State<LineHistoryBody> {

  List deptList;
  List lineList;
  List paramList;

  List<DropdownMenuItem> deptItems = List();
  List<DropdownMenuItem> lineItems = List();
  List<DropdownMenuItem> paramItems = List();

  String todayStr;

  Future lineHisData;

  @override
  void initState() {
    super.initState();
    _getDeptList();
    var today = DateTime.now();
    todayStr = formatDate(today, [yyyy, '-', mm, '-', dd]);
  }

  //获取车间下拉数据
  _getDeptList() async {
    var bukrs = '1008';
    deptList = await DataDao.getDeptList(bukrs);
    DropdownMenuItem item;
    for(int i = 0;i < deptList.length;i++) {
      item = DropdownMenuItem(
        child: Text(deptList[i]['department']),
        value: deptList[i]['department'],
      );
      deptItems.add(item);
    }
    deptValue = deptList[0]['department'];
    _getLine(deptValue);
    setState(() {

    });
  }

  //获取生产线下拉数据
  _getLine(department) async{
    lineList = await DataDao.getLineListData(department);
    _getLineList(lineList);
  }

  _getLineList(lineList) {
    lineItems.clear();
    DropdownMenuItem item;
    for(int i = 0;i < lineList.length;i++) {
      item = DropdownMenuItem(
        child: Text(lineList[i]['line_name']),
        value: lineList[i]['line_name'],
      );
      lineItems.add(item);
    }
    lineValue = lineList[0]['line_name'];
    _getParam(lineValue);
    setState(() {

    });
  }

  //获取生产线下拉数据
  _getParam(lineName) async{
    paramList = await DataDao.getParamList(lineName);
    _getParamList(paramList);
  }

  _getParamList(paramList) {
    paramItems.clear();
    DropdownMenuItem item;
    for(int i = 0;i < paramList.length;i++) {
      item = DropdownMenuItem(
        child: Text(paramList[i]['pointdesc']),
        value: paramList[i]['pointdesc'],
      );
      paramItems.add(item);
    }
    paramValue = paramList[0]['pointdesc'];
    setState(() {

    });
  }

  //显示曲线
  _showLine() {
    var formatDateStr = formatDate(DateTime.parse(todayStr), [yyyy, '/', mm, '/', dd]);
    lineHisData = DataDao.getLineHisData(deptValue, lineValue, paramValue, formatDateStr);
    setState(() {

    });
  }

  var deptValue;
  var lineValue;
  var paramValue;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('车    间：',style: WMConstant.middleText,),
              Padding(padding: EdgeInsets.all(20)),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: deptItems,
                      value: deptValue,
                      elevation: 24,
                      onChanged: (v) async {
                        await _getLine(v);
                        setState(() {
                          deptValue = v;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
          Row(
            children: <Widget>[
              Text('生产线：',style: WMConstant.middleText,),
              Padding(padding: EdgeInsets.all(20)),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: lineItems,
                      value: lineValue,
                      elevation: 24,
                      onChanged: (v) async {
                        await _getParam(v);
                        setState(() {
                          lineValue = v;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
          Row(
            children: <Widget>[
              Text('参    数：',style: WMConstant.middleText,),
              Padding(padding: EdgeInsets.all(20)),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: paramItems,
                      value: paramValue,
                      elevation: 24,
                      onChanged: (v) {
                        setState(() {
                          paramValue = v;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
          Row(
            children: <Widget>[
              Text('时    间：',style: WMConstant.middleText,),
              Padding(padding: EdgeInsets.all(20)),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Text(todayStr),
                  ),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(todayStr),
                      firstDate: DateTime(2016),
                      lastDate: DateTime(2030),
                      builder: (BuildContext context, Widget child) {
                        return Theme(
                          data: ThemeData.dark(),
                          child: child,
                        );
                      },
                    ).then((date){
                      setState(() {
                        if(date != null){
                          todayStr = formatDate(date, [yyyy, '-', mm, '-', dd]);
                        }
                      });
                    });
                  },
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.blue
                ),
                child: FlatButton(
                  onPressed: () {
                    _showLine();
                  },
                  child: Text('确定'),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
          SingleChildScrollView(
            child: Container(
              height: 300,
              width: 500,
              decoration: BoxDecoration(
                  border: Border.all(width: 1)
              ),
              child: FutureBuilder(
                future: lineHisData,
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
                      case ConnectionState.done:
                        if(snapshot.hasError) {
                          return Container();
                        }else if(snapshot.hasData) {
                          if(snapshot.data != '') {
                            return LineHisRun(snapshot.data);
                          }else {
                            return Container(
                              child: Center(
                                child: Text('暂无数据'),
                              ),
                            );
                          }
                        }else {
                          return Container();
                        }
                        break;
                      default:
                        return Container();
                        break;
                    }
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class LineHisRun extends StatelessWidget {

  final List dotList;

  LineHisRun(this.dotList);
  
  final weekDays = [
    '0',
    '2',
    '4',
    '6',
    '8',
    '10',
    '12',
    '14',
    '16',
    '18',
    '20',
    '22',
    '24',
    '(时)',
  ];

  xCoordinate(String timeStr) {
    timeStr = timeStr.replaceAll('.', ':');
    List tempStr = timeStr.split(':');
    double ratio =(_strToDouble(tempStr[2])+_strToDouble(tempStr[1])*60+_strToDouble(tempStr[0])*3600)/86400;
    return ratio*12;
  }

  yCoordinate(value) {
    return 1 + (value - dotList[0]['sp'])/dotList[0]['dev'];
  }

  _strToDouble(str) {
    return double.parse(str);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text(
              '历史运行曲线',
              style: WMConstant.middleText,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 300,
          height: 240,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                  getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                    return spotIndexes.map((spotIndex) {
                      final FlSpot spot = barData.spots[spotIndex];
                      if (spot.x == 0 || spot.x == 12) {
                        return null;
                      }
                      return TouchedSpotIndicatorData(
                        FlLine(color: Colors.blue, strokeWidth: 4),
                        FlDotData(
                          dotSize: 2,
                          strokeWidth: 2,
                          getDotColor: (spot, percent, barData) => Colors.white,
                          getStrokeColor: (spot, percent, barData) => Colors.blue,
                        ),
                      );
                    }).toList();
                  },
                  touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.blueAccent,
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          final flSpot = barSpot;
                          if (flSpot.x == 0 || flSpot.x == 12) {
                            return null;
                          }

                          return LineTooltipItem(
                            '${weekDays[flSpot.x.toInt()]} \n${flSpot.y}',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      })),
              extraLinesData: ExtraLinesData(horizontalLines: [
                HorizontalLine(
                  y: yCoordinate(dotList[0]['sp']),
                  color: Colors.green.withOpacity(0.7),
                  strokeWidth: 4,
                ),
              ]),
              lineBarsData: [
                LineChartBarData(
                spots: dotList.map((dot) {
                  return FlSpot(xCoordinate(dot['valuetime']), yCoordinate(dot['pointvalue']));
                }).toList(),
                  isCurved: false,
                  barWidth: 2,//折线宽度
                  colors: [//折线颜色
                    Colors.blue,
                  ],
                  belowBarData: BarAreaData(
                    show: true,
                    colors: [
                      Colors.orange.withOpacity(0.5),
                      Colors.orange.withOpacity(0.0),
                    ],
                    gradientColorStops: [0.5, 1.0],
                    gradientFrom: const Offset(0, 0),
                    gradientTo: const Offset(0, 1),
                    spotsLine: BarAreaSpotsLine(
                      show: true,
                      flLineStyle: FlLine(
                        color: Colors.red,
                        strokeWidth: 2,
                      ),
                      checkToShowSpotLine: (spot) {
                        if (spot.x == 0 || spot.x == 12) {
                          return false;
                        }

                        return true;
                      },
                    ),
                  ),
                  dotData: FlDotData(
                      show: true,
                      getDotColor: (spot, percent, barData) => Colors.white,
                      dotSize: 1,
                      strokeWidth: 1,
                      getStrokeColor: (spot, percent, barData) => Colors.deepOrange,
                      checkToShowDot: (spot) {
                        return spot.x != 0 && spot.x != 12;
                      }),
                ),
              ],
              minY: 0,
              maxY: 2,
              maxX: 14,
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  if (value == 0) {
                    return FlLine(
                      color: Colors.deepOrange,
                      strokeWidth: 2,
                    );
                  } else {
                    return FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    );
                  }
                },
                getDrawingVerticalLine: (value) {
                  if (value == 0) {
                    return FlLine(
                      color: Colors.black,
                      strokeWidth: 2,
                    );
                  } else {
                    return FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    );
                  }
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 0:
                        return '${dotList[0]['sp']-dotList[0]['dev']}';
                      case 1:
                        return '${dotList[0]['sp']}';
                      case 2:
                        return '${dotList[0]['sp']+dotList[0]['dev']}';
                    }

                    return '';
                  },
                  textStyle: const TextStyle(color: Colors.black, fontSize: 10),
                ),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) {
                    return weekDays[value.toInt()];
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}