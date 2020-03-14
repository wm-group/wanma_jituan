import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/data_dao.dart';

class DeliveryTracking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发货跟踪'),
      ),
      body: OrderStatusBody(),
    );
  }
}

class OrderStatusBody extends StatefulWidget {
  @override
  _OrderStatusBodyState createState() => _OrderStatusBodyState();
}

class _OrderStatusBodyState extends State<OrderStatusBody> {

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getDeliveryTracking();
  }

  Future _getDeliveryTracking() async {
    String bukrs = '1008';
    var data = await DataDao.getDeliveryTracking(bukrs);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return DeliveryTrackingTable(_futureStr);
  }
}

class DeliveryTrackingTable extends StatefulWidget {
  final Future _futureStr;
  DeliveryTrackingTable(this._futureStr);

  @override
  _DeliveryTrackingTableState createState() => _DeliveryTrackingTableState();
}

class _DeliveryTrackingTableState extends State<DeliveryTrackingTable> {
  List dataList;
  int _sortColumnIndex;
  bool _sortAscending = true;
  DeliveryTrackingDataSource _dataSource;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _sort(int index, bool ascending, String title, {bool method = false}) {
    setState(() {
      _sortColumnIndex = index;
      _sortAscending = ascending;
      dataList.sort((a, b) {
        if(!ascending) {
          final c = a;
          a = b;
          b = c;
        }
        if(method){
          return a[title].compareTo(b[title]);
        }else {
          return a[title].hashCode.compareTo(b[title].hashCode);
        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: widget._futureStr,
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
            case ConnectionState.done:
              if(snapshot.hasError) {
                return Container();
              }else if(snapshot.hasData) {
                dataList = snapshot.data;
                _dataSource = DeliveryTrackingDataSource(dataList);
//                  dataList = JsonDecoder().convert(JsonString.tempData);
                return ListView(
                  children: <Widget>[
                    PaginatedDataTable(
                      header: Text('发货跟踪表'),
                      rowsPerPage: _rowsPerPage,
                      onRowsPerPageChanged: (int value) { setState(() { _rowsPerPage = value; }); },
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: <DataColumn>[
                        DataColumn(
                            label: Text('客户'),
                            onSort: (int index, bool ascending) {
                              _sort(index, ascending, 'kh');
                            }
                        ),
                        DataColumn(
                          label: Text('产品'),
                        ),
                        DataColumn(
                            label: Text('数量'),
                            onSort: (int index, bool ascending) {
                              _sort(index, ascending, 'sl', method: true);
                            }
                        ),
                        DataColumn(
                            label: Text('要求发货日期'),
                            onSort: (int index, bool ascending) {
                              _sort(index, ascending, 'pdrq', method: true);
                            }
                        ),
                        DataColumn(
                            label: Text('仓库操作时间'),
                            onSort: (int index, bool ascending) {
                              _sort(index, ascending, 'fhrq', method: true);
                            }
                        ),
                      ],
                      source: _dataSource,
                    )
//                    DataTable(
//                      columnSpacing: 4,
//                      horizontalMargin: 4,
//                      sortColumnIndex: _sortColumnIndex,
//                      sortAscending: _sortAscending,
//                      columns: [
//                        DataColumn(
//                            label: Text('客户'),
//                            onSort: (int index, bool ascending) {
//                              _sort(index, ascending, 'kh');
//                            }
//                        ),
//                        DataColumn(
//                            label: Text('产品'),
//                        ),
//                        DataColumn(
//                            label: Text('数量'),
//                            onSort: (int index, bool ascending) {
//                              _sort(index, ascending, 'sl', method: true);
//                            }
//                        ),
//                        DataColumn(
//                            label: Text('要求发货日期'),
//                            onSort: (int index, bool ascending) {
//                              _sort(index, ascending, 'pdrq', method: true);
//                            }
//                        ),
//                        DataColumn(
//                            label: Text('仓库操作时间'),
//                            onSort: (int index, bool ascending) {
//                              _sort(index, ascending, 'fhrq', method: true);
//                            }
//                        ),
//                      ],
//                      rows: dataList.map((data) {
//                        return DataRow(
//                            cells: [
//                              DataCell(Text('${data['kh']}')),
//                              DataCell(Text('${data['cp']}')),
//                              DataCell(Text('${data['sl']}')),
//                              DataCell(Text('${data['pdrq']}')),
//                              DataCell(Text('${data['fhrq']}')),
//                            ]
//                        );
//                      }).toList(),
//                    )
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

class DeliveryTrackingDataSource extends DataTableSource {

  final List _dataList;
  DeliveryTrackingDataSource(this._dataList);

  @override
  DataRow getRow(int index) {
    if (index >= _dataList.length)
      return null;
    final Map temp = _dataList[index];
    return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          DataCell(Text('${temp['kh']}')),
          DataCell(Text('${temp['cp']}')),
          DataCell(Text('${temp['sl']}')),
          DataCell(Text('${temp['pdrq']}')),
          DataCell(Text('${temp['fhrq']}')),
        ]);
  }

  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _dataList.length;
}


