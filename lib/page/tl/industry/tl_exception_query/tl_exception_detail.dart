import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/tl_dao.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';

class TLExceptionDetail extends StatelessWidget {

  final String lineNo;
  final String startDate;
  final String endDate;

  TLExceptionDetail(this.lineNo, this.startDate, this.endDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('芯线异常明细'),
      ),
      body: ExceptionDetailBody(lineNo, startDate, endDate),
    );
  }
}

class ExceptionDetailBody extends StatefulWidget {

  final String lineNo;
  final String startDate;
  final String endDate;

  ExceptionDetailBody(this.lineNo, this.startDate, this.endDate);

  @override
  _ExceptionDetailBodyState createState() => _ExceptionDetailBodyState();
}

class _ExceptionDetailBodyState extends State<ExceptionDetailBody> {

  List _dataList;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTLExceptionDetail();
  }

  _getTLExceptionDetail() async {
    _dataList = await TLDao.getTLExceptionDetail(widget.startDate, widget.endDate, widget.lineNo);
    if(!mounted) {
      return;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
              children: <Widget>[
                _getTitleContainer('时间'),
                _getTitleContainer('热外径'),
                _getTitleContainer('电容值'),
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
                border: TableBorder.all(width: 1),
                children: _tableList(_dataList),
              ),
            ],
          ),
        ),
      ],
    );
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

  _getContentContainer(content, {set = '0'}) {
    return TableRowInkWell(
      onTap: () {
      },
      child: Container(
        color: set == '1' ? Colors.red : Colors.white,
        height: 50,
        child: Center(
          child: Text('$content'),
        ),
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
            _getContentContainer(dataList[i]['happend_time']),
            _getContentContainer(dataList[i]['hot_diameter'], set: '${dataList[i]['hot_diameter_set']}'),
            _getContentContainer(dataList[i]['elec'], set: '${dataList[i]['elec_set']}'),
          ],
        );
        _tableRowList.add(_tableRow);
      }
    }
    return _tableRowList;
  }
}

