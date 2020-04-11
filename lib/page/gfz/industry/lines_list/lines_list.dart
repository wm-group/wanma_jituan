import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class LinesList extends StatefulWidget {
  @override
  _LinesListState createState() => _LinesListState();
}

class _LinesListState extends State<LinesList> {

  Future _futureStr;

  List dataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getLinesListData();
  }

  Future _getLinesListData() async {
    String bukrs = '1008';
    var data = await DataDao.getLinesListData(bukrs);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('生产线列表'),
      ),
      body: Container(
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
                          DataColumn(label: Text('车间'),),
                          DataColumn(label: Text('运行'),),
                          DataColumn(label: Text('异常运行'),),
                          DataColumn(label: Text('检修'),),
                        ],
                        rows: dataList.map((data) {
                          return DataRow(
                              cells: [
                                DataCell(
                                  Text('${data['department']}'),
                                  onTap: () {
                                    NavigatorUtils.goLineList(context, data['department']);
                                  },
                                ),
                                DataCell(Text('${data['run']}')),
                                DataCell(Text('${data['exceptrun']}')),
                                DataCell(Text('${data['repair']}')),
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
      ),
    );
  }
}