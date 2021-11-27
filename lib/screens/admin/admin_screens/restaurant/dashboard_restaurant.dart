import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/add_button.dart';
import 'package:tembea/components/responsive.dart';
import 'package:tembea/components/show_dialog.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/screens/admin/admin_screens/restaurant/form/restaurant_main_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:tembea/screens/admin/admin_screens/restaurant/view_restaurant.dart';

class DashboardRestaurant extends StatefulWidget {
  const DashboardRestaurant({Key? key}) : super(key: key);
  static String id = 'dashboard_restaurant';

  @override
  _DashboardRestaurantState createState() => _DashboardRestaurantState();
}

class _DashboardRestaurantState extends State<DashboardRestaurant> {
  final Stream<QuerySnapshot> activities = FirebaseFirestore
      .instance.collection('activities')
      .where('Type', isEqualTo: 'Restaurant')
      .orderBy('ts', descending: true)
      .snapshots();

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: showSpinner,
      opacity: 0.5,
      color: Colors.green,
      progressIndicator: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.green),
      ),
      child:Column(
                children:  [
                  AddButton(
                    title: 'Restaurants',
                    addLabel: 'Add Restaurant',
                    onPressed: (){
                      Navigator.pushNamed(context, RestaurantMainForm.id);
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
                        return ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                              width: 360,
                            height: 250,
                          ),
                          child: ListView.builder(
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
                                          child:data.docs[index] == null ? Image.asset('assets/images/image.png') : Image.network(
                                            data.docs[index]['PhotoUrl'],
                                          ) ,
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
                                          addLabel: 'View Restaurant',
                                          color: Colors.green,
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return ViewRestaurant(
                                                restaurant: data.docs[index],
                                              );
                                            }));
                                          },
                                          icon: const Icon(IconData(61161, fontFamily: 'MaterialIcons')),
                                        ) : InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return ViewRestaurant(
                                                restaurant: data.docs[index],
                                              );
                                            }));
                                          },
                                          child: const Icon(IconData(61161, fontFamily: 'MaterialIcons')),
                                        ),
                                        Responsive.isWeb(context) ? ButtonBlue(
                                          addLabel: 'Delete Restaurant',
                                          color: Colors.red,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context){
                                                  return ShowDialog(
                                                    deleteFunction: () async{
                                                      await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                        FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl']).delete();
                                                        FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl1']).delete();
                                                        FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl2']).delete();
                                                        myTransaction.delete(snapshot.data!.docs[index].reference);
                                                      });
                                                    },
                                                    dialogTitle: "Delete",
                                                    dialogContent: "Do you really want to delete ${data.docs[index]['Name']} restaurant?",
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
                                                        setState(() {
                                                          showSpinner = true;
                                                        });
                                                        await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                          FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl']).delete();
                                                          FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl2']).delete();
                                                          FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl3']).delete();
                                                          myTransaction.delete(snapshot.data!.docs[index].reference);
                                                        }).then((value) {
                                                          setState(() {
                                                            showSpinner = false;
                                                          });
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      dialogTitle: "Delete",
                                                      dialogContent: "Do you really want to delete ${data.docs[index]['Name']} restaurant?",
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
                                                          FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl2']).delete();
                                                          FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl3']).delete();
                                                          myTransaction.delete(snapshot.data!.docs[index].reference);
                                                        }).then((value) => Navigator.pop(context));
                                                      },
                                                      dialogTitle: "Delete",
                                                      dialogContent: "Do you really want to delete ${data.docs[index]['Name']} restaurant?",
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
                                                          FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl2']).delete();
                                                          FirebaseStorage.instance.refFromURL(data.docs[index]['PhotoUrl3']).delete();
                                                          myTransaction.delete(snapshot.data!.docs[index].reference);
                                                          Navigator.pop(context);
                                                          showToast(message: 'Deleted Successfully', color: Colors.green);
                                                        }).then((value) => Navigator.pop(context));
                                                      },
                                                      dialogTitle: "Delete",
                                                      dialogContent: "Do you really want to delete ${data.docs[index]['Name']} restaurant?",
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
                              }),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                ],
              ),
    );
  }
}
