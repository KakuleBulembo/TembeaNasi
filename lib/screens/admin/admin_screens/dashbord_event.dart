import 'package:flutter/material.dart';
import 'package:tembea/components/add_button.dart';
import 'package:tembea/components/responsive.dart';
import 'event_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DashboardEvent extends StatefulWidget {
  const DashboardEvent({Key? key}) : super(key: key);
  static String id = 'dashboard_event';

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
           onPressed: (){
             Navigator.pushNamed(context, EventForm.id);
           },),
        const SizedBox(
          height: 16.0,
        ),
        const Divider(
          color: Colors.white70,
          height:40.0,
        ),


      ],
    );
  }
}

// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// const CircleAvatar(
// backgroundColor: Colors.green,
// radius: 40,
// ),
// const Text('Event\'s name', style: TextStyle(color: Colors.white70),),
// Responsive.isWeb(context) ? ButtonBlue(
// addLabel: 'Edit Event',
// color: Colors.green,
// onPressed: (){},
// icon: const Icon(IconData(61161, fontFamily: 'MaterialIcons')),
// ) : InkWell(
// onTap: (){},
// child: const Icon(IconData(61161, fontFamily: 'MaterialIcons')),
// ),
// Responsive.isWeb(context) ? ButtonBlue(
// addLabel: 'Delete Event',
// color: Colors.red,
// onPressed: (){},
// icon: const Icon(Icons.delete_outline,),
// ): InkWell(
// onTap: (){},
// child:  const Icon(Icons.delete_outline,),
// ),
// ],
// ),