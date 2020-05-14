import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/tl_dao.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';
import 'package:wanma_jituan/common/utils/common_utils.dart';

class TLExceptionQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('芯线异常查询'),
      ),
      body: ExceptionQueryBody(),
    );
  }
}

class ExceptionQueryBody extends StatefulWidget {
  @override
  _ExceptionQueryBodyState createState() => _ExceptionQueryBodyState();
}

class _ExceptionQueryBodyState extends State<ExceptionQueryBody> {

  String _startDate;
  String _endDate;

  List _dataList;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _endDate = CommonUtils.dateFormat(DateTime.now());
    _startDate = CommonUtils.dateFormat(DateTime.now().add(Duration(days: -DateTime.now().day + 1)));
    _getTLExceptionQuery(_startDate, _endDate);
  }

  _getTLExceptionQuery(startDate, endDate) async {
    _dataList = await TLDao.getTLExceptionQuery(startDate, endDate);
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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(_startDate),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2030),
                      locale: Locale.fromSubtags(languageCode: 'zh'),
                    ).then((date) {
                      if(date != null) {
                        setState(() {
                          _startDate = CommonUtils.dateFormat(date);
                        });
                      }
                    });
                  },
                  child: Text(_startDate),
                ),
                Text('---'),
                FlatButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(_endDate),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2030),
                      locale: Locale.fromSubtags(languageCode: 'zh'),
                    ).then((date) {
                      if(date != null) {
                        setState(() {
                          _endDate = CommonUtils.dateFormat(date);
                        });
                      }
                    });
                  },
                  child: Text(_endDate),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    _getTLExceptionQuery(_startDate, _endDate);
                  },
                  child: Text('确定', style: WMConstant.middleTextWhite,),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(10)),
          Container(
            child: Row(
                children: <Widget>[
                  _getTitleContainer('线号'),
                  _getTitleContainer('异常数'),
                ]
            ),
          ),
          isLoading ? Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ) :
          Expanded(
            child: ListView(
              children: <Widget>[
                Table(
                  children: _tableList(_dataList),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<TableRow> _tableList(dataList) {
    TableRow _tableRow;
    List<TableRow> _tableRowList = <TableRow>[
    ];
    if(dataList != null && dataList.length > 0) {
      for(int i = 0;i < dataList.length;i++) {
        _tableRow = TableRow(
          children: <Widget>[
            _getContentContainer(dataList[i]['line_name'], dataList[i]),
            _getContentContainer(dataList[i]['error_count'], dataList[i]),
          ],
        );
        _tableRowList.add(_tableRow);
      }
    }
    return _tableRowList;
  }

  _getTitleContainer(title) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 60,
        color: Theme.of(context).primaryColor,
        child: Center(child: Text(title, style: WMConstant.normalTextWhite,),),
      ),
    );
  }

  _getContentContainer(content, tempMap) {
    return TableRowInkWell(
      onTap: () {
        NavigatorUtils.goTLExceptionDetail(context, '${tempMap['line_no']}', _startDate, _endDate);
      },
      child: Container(
          height: 50,
          child: Center(
            child: Text('$content'),
          )
      ),
    );
  }
}
