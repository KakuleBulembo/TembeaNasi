import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tembea/components/add_button.dart';
import 'package:tembea/components/responsive.dart';
import 'package:tembea/components/show_dialog.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/screens/admin/admin_screens/games/view_game.dart';

import 'form/game_main_form.dart';

class DashboardGame extends StatefulWidget {
  const DashboardGame({
    Key? key
  }) : super(key: key);
  static String id = 'dashboard_game';

  @override
  _DashboardGameState createState() => _DashboardGameState();
}

class _DashboardGameState extends State<DashboardGame> {
  final Stream<QuerySnapshot> activities = FirebaseFirestore
      .instance.collection('activities')
      .where('Type', isEqualTo: 'Game')
      .orderBy('ts', descending: true)
      .snapshots();


  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        AddButton(
          title: 'Games',
          addLabel: 'Add Game',
          onPressed: (){
            Navigator.pushNamed(context, GameMainForm.id);
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
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                ),
              );
            }
            final data = snapshot.requireData;
            if(data != null){
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.size,
                  itemBuilder: (context, index){
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
                              addLabel: 'View Game',
                              color: Colors.green,
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return ViewGame(activity: data.docs[index],);
                                }));
                              },
                              icon: const Icon(IconData(61161, fontFamily: 'MaterialIcons')),
                            ) : InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return ViewGame(activity: data.docs[index],);
                                }));
                              },
                              child: const Icon(IconData(61161, fontFamily: 'MaterialIcons')),
                            ),
                            Responsive.isWeb(context) ? ButtonBlue(
                              addLabel: 'Delete Event',
                              color: Colors.red,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return ShowDialog(
                                        deleteFunction: () async{
                                          await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                            FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl3']).delete().then((value) {
                                              FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl2']).delete().then((value){
                                                FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl']).delete();
                                              });
                                            });
                                            myTransaction.delete(snapshot.data!.docs[index].reference);
                                          }).then((value) => Navigator.pop(context));
                                        },
                                        dialogTitle: "Delete",
                                        dialogContent: "Do you really want to delete ${data.docs[index]['Name']} gym?",
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
                                            }).then((value) => Navigator.pop(context));
                                            showToast(message: 'Deleted Successfully', color: Colors.green);
                                          },
                                          dialogTitle: "Delete",
                                          dialogContent: "Do you really want to delete ${data.docs[index]['Name']} gym?",
                                        );
                                      });
                                }
                                else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return ShowDialog(
                                          deleteFunction: () async{
                                            await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                              FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl']).delete();
                                              myTransaction.delete(snapshot.data!.docs[index].reference);
                                            }).then((value) => Navigator.pop(context));
                                            showToast(message: 'Deleted Successfully', color: Colors.green);
                                          },
                                          dialogTitle: "Delete",
                                          dialogContent: "Do you really want to delete ${data.docs[index]['Name']} gym?",
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
