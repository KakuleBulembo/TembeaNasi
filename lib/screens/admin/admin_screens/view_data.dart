import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ViewData extends StatefulWidget {
   const ViewData({
    Key? key,
    required this.item,
  }) : super(key: key);
  final DocumentSnapshot item;
  static String id = 'view_data';

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(widget.item['Name']),
      ),
    );
  }
}
