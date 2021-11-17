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
  final Stream<QuerySnapshot> activities = FirebaseFirestore
      .instance.collection('activities').orderBy('ts', descending: true).snapshots();
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
        StreamBuilder<QuerySnapshot>(
          stream: activities,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = snapshot.requireData;
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                itemCount: data.size,
                  itemBuilder: (context, index){
                    if(data.docs[index]['Type'] == 'Event'){
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 40,
                                child: Image.network(data.docs[index]['PhotoUrl']),
                              ),
                              Text( data.docs[index]['Name'], style:const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),

                              ),
                              Responsive.isWeb(context) ? ButtonBlue(
                                addLabel: 'Edit Event',
                                color: Colors.green,
                                onPressed: (){},
                                icon: const Icon(IconData(61161, fontFamily: 'MaterialIcons')),
                              ) : InkWell(
                                onTap: (){},
                                child: const Icon(IconData(61161, fontFamily: 'MaterialIcons')),
                              ),
                              Responsive.isWeb(context) ? ButtonBlue(
                                addLabel: 'Delete Event',
                                color: Colors.red,
                                onPressed: (){},
                                icon: const Icon(Icons.delete_outline,),
                              ): InkWell(
                                onTap: (){},
                                child:  const Icon(Icons.delete_outline,),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white70,
                            height:40.0,
                          ),
                        ],
                      );
                    }
                    return Container();
                  });
            },
        )
      ],
    );
  }
}

