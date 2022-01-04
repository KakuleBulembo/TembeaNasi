import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tembea/components/search_engine.dart';
import 'package:tembea/screens/user/view_activity.dart';
//import 'package:async/async.dart' show StreamGroup;

class SearchDashboard extends StatefulWidget {
  const SearchDashboard({Key? key}) : super(key: key);

  @override
  _SearchDashboardState createState() => _SearchDashboardState();
}

class _SearchDashboardState extends State<SearchDashboard> {
  String query = '';
  Stream ? streamQuery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchEngine(
          onChanged: (value){
            setState(() {
              if(value.isNotEmpty){
                setState(() {
                  query = value[0].toUpperCase() + value.substring(1);
                  streamQuery = FirebaseFirestore.instance.collection('activities')
                      .where('Type', isGreaterThanOrEqualTo: query)
                      .where('Type', isLessThan: query + 'z')
                      .snapshots();
                });
              }
            });
          },
          text: query,
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          height: 20,
          color: Colors.green,
        ),
        const SizedBox(
          height: 20,
        ),
        streamQuery != null ? StreamBuilder(
          stream: streamQuery,
            builder:(context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                  ),
                );
              }
              final data = snapshot.requireData;
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.50,
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                    IconData(0xe567, fontFamily: 'MaterialIcons'),
                                  color: Colors.green,
                                ),
                                Text(
                                    data.docs[index]['Name'],
                                  style: GoogleFonts.abel(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 23
                                ),
                                Text(
                                  data.docs[index]['Type'],
                                  style: GoogleFonts.abel(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    }
                ),
              );
            }
        ) :  Center(
          child: Text(
            'Search for Anything',
            style: GoogleFonts.aBeeZee(
              textStyle:const TextStyle(
                fontSize: 22,
                color: Colors.white70,
                fontWeight: FontWeight.bold
              )
            ),
          ),
        ),
      ],
    );
  }
}
