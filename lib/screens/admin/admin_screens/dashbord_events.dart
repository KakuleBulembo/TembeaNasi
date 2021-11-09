import 'package:flutter/material.dart';
import 'package:tembea/components/add_button.dart';

class DashboardEvent extends StatefulWidget {
  const DashboardEvent({Key? key}) : super(key: key);

  @override
  _DashboardEventState createState() => _DashboardEventState();
}

class _DashboardEventState extends State<DashboardEvent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
         AddButton(
           title: 'Events',
           addLabel: 'Add Events',
           onPressed: (){},),
        const SizedBox(
          height: 16.0,
        )
      ],
    );
  }
}

