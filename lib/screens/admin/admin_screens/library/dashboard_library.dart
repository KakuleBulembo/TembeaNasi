import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tembea/components/add_button.dart';
import 'package:tembea/components/responsive.dart';
import 'package:tembea/components/show_dialog.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/screens/admin/admin_screens/event/view_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';



class DashboardLibrary extends StatefulWidget {
  const DashboardLibrary({Key? key}) : super(key: key);
  static String id = 'dashboard_library';

  @override
  _DashboardLibraryState createState() => _DashboardLibraryState();
}

class _DashboardLibraryState extends State<DashboardLibrary> {
  final Stream<QuerySnapshot> activities = FirebaseFirestore
      .instance.collection('activities')
      .where('Type', isEqualTo: 'Library')
      .orderBy('ts', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        AddButton(
          title: 'Libraries',
          addLabel: 'Add Library',
          onPressed: (){
           // Navigator.pushNamed(context, );
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
            if(data != null){
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.size,
                  itemBuilder: (context, index){
                    if(data.docs[index]['Type'] == 'Library'){
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 40,
                                child:Image.network(
                                  data.docs[index]['PhotoUrl'],
                                ),
                              ),
                              Text( data.docs[index]['Name'], style:const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),

                              ),
                              if(Responsive.isWeb(context))
                                const SizedBox(
                                  width: 50,
                                ),
                              Responsive.isWeb(context) ? ButtonBlue(
                                addLabel: 'View Library',
                                color: Colors.green,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return ViewData(activity: data.docs[index],);
                                  }));
                                },
                                icon: const Icon(IconData(61161, fontFamily: 'MaterialIcons')),
                              ) : InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return ViewData(activity: data.docs[index],);
                                  }));
                                },
                                child: const Icon(IconData(61161, fontFamily: 'MaterialIcons')),
                              ),
                              Responsive.isWeb(context) ? ButtonBlue(
                                addLabel: 'Delete Library',
                                color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return ShowDialog(
                                          deleteFunction: () async{
                                            await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                              FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl']).delete();
                                              myTransaction.delete(snapshot.data!.docs[index].reference);
                                            });
                                          },
                                          dialogTitle: "Delete",
                                          dialogContent: "Do you really want to delete ${data.docs[index]['Name']} library?",
                                        );
                                      });
                                },
                                icon: const Icon(Icons.delete_outline,),
                              ): InkWell(
                                onTap: (){
                                  if(defaultTargetPlatform == TargetPlatform.iOS){
                                    showCupertinoDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return ShowDialog(
                                            deleteFunction: () async{
                                              await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl']).delete();
                                                myTransaction.delete(snapshot.data!.docs[index].reference);
                                              });
                                            },
                                            dialogTitle: "Delete",
                                            dialogContent: "Do you really want to delete ${data.docs[index]['Name']} library?",
                                          );
                                        });
                                  }
                                  else if((defaultTargetPlatform == TargetPlatform.android)){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return ShowDialog(
                                            deleteFunction: () async{
                                              await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl']).delete();
                                                myTransaction.delete(snapshot.data!.docs[index].reference);
                                              });
                                            },
                                            dialogTitle: "Delete",
                                            dialogContent: "Do you really want to delete ${data.docs[index]['Name']} library?",
                                          );
                                        });
                                  }
                                  else{
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return ShowDialog(
                                            deleteFunction: () async{
                                              await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl']).delete();
                                                myTransaction.delete(snapshot.data!.docs[index].reference);
                                                Navigator.pop(context);
                                                showToast(message: 'Deleted Successfully', color: Colors.green);
                                              });
                                            },
                                            dialogTitle: "Delete",
                                            dialogContent: "Do you really want to delete ${data.docs[index]['Name']} library?",
                                          );
                                        });
                                  }
                                },
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
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ],
    );
  }
}
