import 'package:flutter/material.dart';

class LineHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('历史运行曲线'),
      ),
      body: LineHistoryBody(),
    );
  }
}

class LineHistoryBody extends StatefulWidget {
  @override
  _LineHistoryBodyState createState() => _LineHistoryBodyState();
}

class _LineHistoryBodyState extends State<LineHistoryBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

