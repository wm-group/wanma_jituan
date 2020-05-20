import 'package:flutter/material.dart';

class TYInventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('半成品盘点'),
      ),
      body: TYInventoryBody(),
    );
  }
}

class TYInventoryBody extends StatefulWidget {
  @override
  _TYInventoryBodyState createState() => _TYInventoryBodyState();
}

class _TYInventoryBodyState extends State<TYInventoryBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

