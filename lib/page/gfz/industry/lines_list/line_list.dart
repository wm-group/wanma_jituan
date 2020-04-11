import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class LineList extends StatelessWidget {

  final String department;
  LineList({this.department});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('生产线列表'),
        ),
        body: LineListBody(department)
    );
  }
}

class LineListBody extends StatefulWidget {
  final String department;
  LineListBody(this.department);

  @override
  _LineListBodyState createState() => _LineListBodyState();
}

class _LineListBodyState extends State<LineListBody> {

  List dataList;

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getLineListData();
  }

  Future _getLineListData() async {
    var department = widget.department;
    var data = await DataDao.getLineListData(department);
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
                    DataTable(
                      columnSpacing: 4,
                      horizontalMargin: 4,
                      columns: [
                        DataColumn(label: Text('线编号'),),
                        DataColumn(label: Text('线名称'),),
                        DataColumn(label: Text('当前状态'),),
                      ],
                      rows: dataList.map((data) {
                        return DataRow(
                            cells: [
                              DataCell(
                                Text('${data['line_no']}',),
                                onTap: () {
                                  NavigatorUtils.goLineDetail(context, data['line_no'], data['line_name']);
                                },
                              ),
                              DataCell(Text('${data['line_name']}')),
                              DataCell(Text('${data['status']}')),
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


