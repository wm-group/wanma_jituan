import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:wanma_jituan/common/json/json_string.dart';
import 'package:wanma_jituan/widget/grid_item.dart';

class BusinessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView(
          padding: const EdgeInsets.all(20.0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              crossAxisSpacing: 10.0
          ),
          children: _getItem(),
        ),
      );
  }

  _getItem() {
    final items = <Widget>[];
    var data = (json.decode(JsonString.gfzReportFormData))['result'];
    for(int i = 0;i<data.length;i++) {
      var item = GridItemWidget(
        text: data[i]['title'],
        functionName: data[i]['functionName'],
        mid: data[i]['id'].toString(),
      );
      items.add(item);
    }
    return items;
  }
}