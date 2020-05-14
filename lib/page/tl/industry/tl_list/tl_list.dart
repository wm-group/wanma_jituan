import 'package:flutter/material.dart';
import 'package:wanma_jituan/common/dao/tl_dao.dart';
import 'package:wanma_jituan/common/style/wm_style.dart';
import 'package:wanma_jituan/common/utils/navigator_utils.dart';

class TLList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('芯线生产量列表'),
      ),
      body: TLListBody(),
    );
  }
}

class TLListBody extends StatefulWidget {
  @override
  _TLListBodyState createState() => _TLListBodyState();
}

class _TLListBodyState extends State<TLListBody> {

  Future _futureStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStr = _getTLLineList();
  }

  _getTLLineList() async {
    var bukrs = '1001';
    var data = await TLDao.getTLLineList(bukrs);
    return data;
  }

  //表格标题
  Widget _getTitleContainer(title) {
    return Container(
      height: 50,
      color: Theme.of(context).primaryColor,
      child: Center(child: Text(title, style: WMConstant.middleTextWhite,),),
    );
  }

  //表格内容文本控件
  _getContentContainer(content, temMap, {flag = false}) {
    return TableRowInkWell(
      onTap: () {
        NavigatorUtils.goTLLineDetails(context, '${temMap['line_no']}', temMap['line_name']);
      },
      child: Container(
        color: !flag ? Colors.white : (content == '运行中' ? Colors.green : Colors.grey),
        height: 50,
        child: Center(
          child: Padding(padding: EdgeInsets.all(5), child: Text('$content'),),
        ),
      ),
    );
  }

  //表格数据
  List<TableRow> _tableList(List dataList) {
    TableRow _tableRow;
    List<TableRow> _tableRowList = <TableRow>[
      TableRow(
        children: <Widget>[
          _getTitleContainer('NO'),
          _getTitleContainer('名称'),
          _getTitleContainer('车间'),
          _getTitleContainer('状态'),
        ]
      )
    ];
    for(int i=0;i<dataList.length;i++) {
      _tableRow = TableRow(
        children: <Widget>[
          _getContentContainer(dataList[i]['line_no'], dataList[i]),
          _getContentContainer(dataList[i]['line_name'], dataList[i]),
          _getContentContainer(dataList[i]['department'], dataList[i]),
          _getContentContainer(dataList[i]['status'], dataList[i],flag: true),
        ]
      );
      _tableRowList.add(_tableRow);
    }
    return _tableRowList;
  }

  //表格
  showTable(List dataList) {
    return ListView(
      children: <Widget>[
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(width: 1),
          children: _tableList(dataList),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureStr,
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting :
            return Center(child: CircularProgressIndicator(semanticsLabel: '加载中...',),);
          case ConnectionState.done :
            if(snapshot.hasError) {
              return Container();
            }else if(snapshot.hasData) {
              return showTable(snapshot.data);
            }else {
              return Container();
            }
            break;
          default:
            return Container();
            break;
        }
      },
    );
  }
}

