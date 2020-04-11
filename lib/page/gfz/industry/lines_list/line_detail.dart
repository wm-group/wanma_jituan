import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class LineDetail extends StatelessWidget {

  final String lineNo;
  final String lineName;
  LineDetail({this.lineNo, this.lineName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('生产线列表'),
        ),
        body: LineDetailBody(lineNo, lineName)
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

  List dataList;

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getLineDetail();
  }

  Future _getLineDetail() async {
    var lineNo = widget.lineNo;
    var data = await DataDao.getLineDetail(lineNo);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: _futureStr,
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
            case ConnectionState.done:
              if(snapshot.hasError) {
                return Container();
              }else if(snapshot.hasData) {
                dataList = snapshot.data;
//                  dataList = JsonDecoder().convert(JsonString.tempData);
                return ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 2, color: Theme.of(context).primaryColor))
                      ),
                      child: Center(
                        child: Text(widget.lineName, style: WMConstant.bigText,),
                      ),
                    ),
                    DataTable(
                      columnSpacing: 4,
                      horizontalMargin: 4,
                      columns: [
                        DataColumn(label: Text('参数'),),
                        DataColumn(label: Text('实际值'),),
                        DataColumn(label: Text('上限'),),
                        DataColumn(label: Text('下限'),),
                      ],
                      rows: dataList.map((data) {
                        return DataRow(
                            cells: [
                              DataCell(Text('${data['pointdesc']}')),
                              DataCell(Text('${data['pointvalue']}')),
                              DataCell(Text('${data['hi']}')),
                              DataCell(Text('${data['lo']}')),
                            ]
                        );
                      }).toList(),
                    )
                  ],
                );
              }else {
                return Container();
              }
              break;
            default:
              return null;
              break;
          }
        },
      ),
    );
  }
}


