import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:wanma_jituan/common/dao/tl_dao.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';

class TLMonthQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('芯线月产量查询'),
      ),
      body: MonthQueryBody(),
    );
  }
}

class MonthQueryBody extends StatefulWidget {
  @override
  _MonthQueryBodyState createState() => _MonthQueryBodyState();
}

class _MonthQueryBodyState extends State<MonthQueryBody> {

  String mDate;
  List _dataList;
  List<String> yearsList = ['2010','2011','2012','2013','2014','2015','2016',
    '2017','2018','2019','2020','2021','2022','2023','2024','2025','2026','2027','2028',];

  List<String> titleList = ['线号\\月份(km)', '1月', '2月', '3月', '4月', '5月', '6月', '7月',
    '8月', '9月', '10月', '11月', '12月'];

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mDate = formatDate(DateTime.now(), [yyyy]);
    _getTLMonthQuery();
  }

  _getTLMonthQuery() async {
    _dataList = await TLDao.getTLMonthQuery(mDate);
    if(!mounted) {
      return;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Text('查询年份', style: WMConstant.middleText,),
                Expanded(
                  child: FlatButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: Text('年份选择'),
                          children: yearsList.map((year) {
                            return SimpleDialogOption(
                              child: Padding(padding: EdgeInsets.all(5),child: Text(year),),
                              onPressed: () {
                                Navigator.of(context).pop();
                                mDate = year;
                                setState(() {
                                  isLoading = true;
                                });
                                _getTLMonthQuery();
                              },
                            );
                          }).toList(),
                        );
                      }
                    );
                  },
                  child: Text(mDate, style: WMConstant.middleText,),
                ),
                ),
              ],
            ),
          ),
          isLoading ? Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ) :
          Expanded(
            child: Container(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Table(
                      columnWidths: const <int, TableColumnWidth> {
                        0: FixedColumnWidth(80),
                        1: FixedColumnWidth(80),
                        2: FixedColumnWidth(80),
                        3: FixedColumnWidth(80),
                        4: FixedColumnWidth(80),
                        5: FixedColumnWidth(80),
                        6: FixedColumnWidth(80),
                        7: FixedColumnWidth(80),
                        8: FixedColumnWidth(80),
                        9: FixedColumnWidth(80),
                        10: FixedColumnWidth(80),
                        11: FixedColumnWidth(80),
                        12: FixedColumnWidth(80),
                      },
                      border: TableBorder.all(width: 1),
                      children: _tableList(_dataList),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getTitleContainerList() {
    List<Widget> widgetList = List();
    Widget widget;
    for(int i=0;i<titleList.length;i++) {
      widget = Container(
        color: Theme.of(context).primaryColor,
        height: 60,
        child: Center(child: Text(titleList[i], style: WMConstant.normalTextWhite,),),
      );
      widgetList.add(widget);
    }
    return widgetList;
  }

  _getCellList(lineNo, lineData) {
    List<Widget> widgetList = List(titleList.length);
    if(lineData != null && lineData.length > 0) {
      for(int j=0;j<widgetList.length;j++) {
        widgetList[j] = _getContentContainer('');
        for(int i=0;i<lineData.length;i++) {
          if(j == 0) {
            widgetList[j] = _getContentContainer(lineNo);
          }else {
            if(lineData[i]['prod_month'] == 1) {
              widgetList[1] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }else if(lineData[i]['prod_month'] == 2) {
              widgetList[2] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }else if(lineData[i]['prod_month'] == 3) {
              widgetList[3] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }else if(lineData[i]['prod_month'] == 4) {
              widgetList[4] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }else if(lineData[i]['prod_month'] == 5) {
              widgetList[5] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }else if(lineData[i]['prod_month'] == 6) {
              widgetList[6] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }else if(lineData[i]['prod_month'] == 7) {
              widgetList[7] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }else if(lineData[i]['prod_month'] == 8) {
              widgetList[8] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }else if(lineData[i]['prod_month'] == 9) {
              widgetList[9] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }else if(lineData[i]['prod_month'] == 10) {
              widgetList[10] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }else if(lineData[i]['prod_month'] == 11) {
              widgetList[11] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }else if(lineData[i]['prod_month'] == 12) {
              widgetList[12] = _getContentContainer((lineData[i]['prod_amount']/1000).toStringAsFixed(1));
            }
          }
        }
      }
    }
    return widgetList;
  }

  List<TableRow> _tableList(dataList) {
    List lineData;
    TableRow _tableRow;
    List<TableRow> _tableRowList = <TableRow>[
      TableRow(
        children: _getTitleContainerList()
      )
    ];
    if(dataList != null && dataList.length > 0) {
      for(int i = 0;i < dataList.length;i++) {
        lineData = dataList[i]['data'];
        _tableRow = TableRow(
          children: _getCellList(dataList[i]['line_no'], lineData)
        );
        _tableRowList.add(_tableRow);
      }
    }
    return _tableRowList;
  }

  _getContentContainer(content) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        height: 50,
        child: Center(
          child: Text('$content'),
        ),
      ),
    );
  }
}
