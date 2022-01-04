import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tembea/screens/user/view_activity.dart';

import '../../constants.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({
    Key? key
  }) : super(key: key);
  static String id = 'user_dashboard';

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final Stream<QuerySnapshot> activities = FirebaseFirestore
      .instance.collection('activities')
      .orderBy('avgRating', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
          return Container(
            height: MediaQuery.of(context).size.height * 0.65,
            margin:const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.size,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ViewActivity(activity: data.docs[index]);
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
                                data.docs[index]['PhotoUrl'],
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
                                  Text(data.docs[index]['Name'],
                                    style: GoogleFonts.aBeeZee(
                                        textStyle: TextStyle(
                                          color: Colors.blue.withOpacity(0.8),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )
                                    ),
                                  ),
                                  Text(
                                    data.docs[index]['Type'],
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
                                        '${data.docs[index]['Price']}Ksh',
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
                                        rating: data.docs[index]['numberOfRatings'] > 0 ? data.docs[index]['avgRating']/data.docs[index]['numberOfRatings'] : 0,
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
            ),
          );
        }
    );
  }
}
