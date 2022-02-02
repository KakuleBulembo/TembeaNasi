import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tembea/screens/user/view_activity.dart';

import '../../constants.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({Key? key}) : super(key: key);

  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  final Stream<QuerySnapshot> activities = FirebaseFirestore
      .instance.collection('activities')
      .orderBy('avgRating', descending: true)
      .snapshots();
  Map interest = {};

  getInterest(){
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((value) {
          setState(() {
            interest = value.data()!['interest'];
          });
    });
  }
  @override
  void initState() {
    getInterest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: activities,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
           if(snapshot.hasData){
             final activity = snapshot.requireData;
             return Container(
               height: size.height * 0.65,
               margin:const EdgeInsets.symmetric(
                 horizontal: 0,
               ),
               child: ListView.builder(
                   scrollDirection: Axis.vertical,
                   shrinkWrap: true,
                   itemCount: activity.size,
                   itemBuilder: (context, index){
                     for(var type in interest.entries){
                       if(type.value == true){
                         if(type.key == activity.docs[index]['Type']){
                           return GestureDetector(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context){
                                 return ViewActivity(activity: activity.docs[index]);
                               }));
                             },
                             child: Row(
                               children: [
                                 Expanded(
                                   child: Container(
                                     height: 180,
                                     width: 140,
                                     decoration: BoxDecoration(
                                       color: kSecondaryColor,
                                       borderRadius: BorderRadius.circular(20),
                                     ),
                                     margin:const EdgeInsets.only(top: 30),
                                     child: ClipRRect(
                                       borderRadius: BorderRadius.circular(20.0),
                                       child: Image.network(
                                         activity.docs[index]['PhotoUrl'],
                                         fit: BoxFit.fill,
                                       ),
                                     ),
                                   ),
                                 ),
                                 Expanded(
                                   child: Container(
                                     margin:const EdgeInsets.only(
                                       top: 60,
                                       bottom: 20,
                                     ),
                                     decoration:const BoxDecoration(
                                       color: kSecondaryColor,
                                       borderRadius:BorderRadius.only(
                                         topRight: Radius.circular(20),
                                         bottomRight: Radius.circular(20),
                                       ),
                                     ),
                                     child: Center(
                                       child: Column(
                                         children: [
                                           Text(activity.docs[index]['Name'],
                                             style: GoogleFonts.aBeeZee(
                                                 textStyle: TextStyle(
                                                   color: Colors.blue.withOpacity(0.8),
                                                   fontSize: 20,
                                                   fontWeight: FontWeight.bold,
                                                 )
                                             ),
                                           ),
                                           Text(
                                             activity.docs[index]['Type'],
                                             style: GoogleFonts.acme(
                                                 textStyle:const TextStyle(
                                                   color: Colors.green,
                                                   fontSize: 20,
                                                   fontWeight: FontWeight.bold,
                                                 )
                                             ),
                                           ),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               Text(
                                                 'From ',
                                                 style: GoogleFonts.pacifico(
                                                     textStyle:const TextStyle(
                                                       fontSize: 20,
                                                     )
                                                 ),
                                               ),
                                               Text(
                                                 '${activity.docs[index]['Price']}Ksh',
                                                 style: GoogleFonts.pacifico(
                                                   textStyle:const TextStyle(
                                                     color: Colors.tealAccent,
                                                     fontSize: 20,
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               RatingBarIndicator(
                                                 rating: activity.docs[index]['numberOfRatings'] > 0 ? activity.docs[index]['avgRating']/activity.docs[index]['numberOfRatings'] : 0,
                                                 itemBuilder: (context, index) =>const Icon(
                                                   Icons.star,
                                                   color: Colors.amber,
                                                 ),
                                                 itemCount: 5,
                                                 itemSize: 25.0,
                                                 direction: Axis.horizontal,
                                               ),
                                             ],
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           );
                         }
                       }
                     }
                     return Container();
                   }
               ),
             );
           }
           return Container();
        });
  }
}
