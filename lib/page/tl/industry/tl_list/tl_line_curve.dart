import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:wanma_jituan/common/dao/tl_dao.dart';

class TLLineCurve extends StatefulWidget {
  final String lineNo;
  TLLineCurve(this.lineNo);

  @override
  _TLLineCurveState createState() => _TLLineCurveState();
}

class _TLLineCurveState extends State<TLLineCurve> {

  var title;
  var mtime;
  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    mtime = formatDate(DateTime.now(), [HH, ':', nn, ':', ss]);
    _futureStr = _getTLLineCurve(title, mtime);
  }

  _getTLLineCurve(dateStr, timeStr) async {
    var data = TLDao.getTLLineCurve(widget.lineNo, dateStr, timeStr);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.parse(title),
                firstDate: DateTime(2010),
                lastDate: DateTime(2030),
                locale: Localizations.localeOf(context)
              ).then((date) {
                setState(() {
                  if(date != null) {
                    title = formatDate(date, [yyyy, '-', mm, '-', dd]);
                    _futureStr = _getTLLineCurve(title, mtime);
                  }
                });
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _futureStr,
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
            case ConnectionState.done:
              if(snapshot.hasError) {
                return Container();
              }else if(snapshot.hasData) {
                if(snapshot.data['list'] != null && snapshot.data['list'].length > 0) {
                  return Container(child: Center(child: Text('暂未开发'),),);
                }else {
                  return Container(child: Center(child: Text('暂无数据'),),);
                }
              }else {
                return Container(child: Center(child: Text('暂无数据'),),);
              }
              break;
            default:
              return Container();
              break;
          }
        },
      ),
    );
  }
}



