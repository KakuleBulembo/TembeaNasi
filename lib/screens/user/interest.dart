import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/custom_check_box.dart';
import 'package:tembea/components/rounded_view_details_button.dart';
import 'package:tembea/constants.dart';
import 'package:tembea/screens/user/user_home.dart';

class Interest extends StatefulWidget {
  const Interest({Key? key}) : super(key: key);
  static String id = 'interest';

  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  int ? analysisCinema;
  int ? analysisHotel;
  int ? analysisRestaurant;
  int ? analysisEvent;
  int ? analysisGame;
  int ? analysisGym;
  int ? analysisPool;
  bool cinema = false;
  bool hotel = false;
  bool restaurant = false;
  bool event = false;
  bool game = false;
  bool gym = false;
  bool pool = false;
  Map ? interest;
  String ? adminId;
  bool showSpinner = false;

  @override
  void initState() {
    setState(() {
      getAdmin();
    });
    super.initState();
  }
  getAdmin(){
     FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: true).get().then((value) {
      adminId = value.docs[0]['uid'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: showSpinner,
      opacity: 0.5,
      color: Colors.green,
      progressIndicator: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.green),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Tembea Nasi',
            style: GoogleFonts.acme(
              textStyle:const TextStyle(
                fontSize: 25,
                color: Colors.green,
              ),
            ),
          ),
          backgroundColor: kBackgroundColor,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Select your favorites activity',
                  style: GoogleFonts.acme(
                    textStyle:const TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  CustomCheckBox(
                      isChecked: false,
                      onChanged: (value){
                        cinema = value;
                      },
                      content: 'Cinema'
                  ),
                  CustomCheckBox(
                      isChecked: false,
                      onChanged: (value){
                        hotel = value;
                      },
                      content: 'Hotel'
                  ),
                  CustomCheckBox(
                      isChecked: false,
                      onChanged: (value){
                        restaurant = value;
                      },
                      content: 'Restaurant'
                  ),
                ],
              ),
              Row(
                children: [
                  CustomCheckBox(
                      isChecked: false,
                      onChanged: (value){
                        event = value;
                      },
                      content: 'Event'
                  ),
                  CustomCheckBox(
                      isChecked: false,
                      onChanged: (value){
                        game = value;
                      },
                      content: 'Game'
                  ),
                  CustomCheckBox(
                      isChecked: false,
                      onChanged: (value){
                        gym = value;
                      },
                      content: 'Gym'
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCheckBox(
                      isChecked: false,
                      onChanged: (value){
                        pool = value;
                      },
                      content: 'Pool'
                  ),
                ],
              ),
              Container(
                color: kSecondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RoundedViewDetailsButton(
                          title: 'Submit',
                          onPressed: () async{
                            setState(() {
                              showSpinner = true;
                            });
                            final DocumentSnapshot analysisSnap =
                                await FirebaseFirestore.instance
                                    .collection('interest')
                                    .doc(adminId).get();
                            analysisCinema = analysisSnap['Cinema'];
                            analysisHotel = analysisSnap['Hotel'];
                            analysisRestaurant = analysisSnap['Restaurant'];
                            analysisEvent = analysisSnap['Event'];
                            analysisGame = analysisSnap['Game'];
                            analysisGym = analysisSnap['Gym'];
                            analysisPool = analysisSnap['Pool'];

                            final DocumentSnapshot snapshot =
                                await FirebaseFirestore
                                .instance.collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid).get();
                            interest = snapshot['interest'];
                            interest!['Cinema'] = cinema;
                            interest!['Hotel'] = hotel;
                            interest!['Restaurant'] = restaurant;
                            interest!['Event'] = event;
                            interest!['Game'] = game;
                            interest!['Gym'] = gym;
                            interest!['Pool'] = pool;
                            FirebaseFirestore
                                .instance.collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid).update({
                              'interest' : interest
                            });
                            FirebaseFirestore.instance.collection('interest')
                                .doc(adminId).update({
                              'Cinema' : cinema == true ? analysisCinema! + 1 : analysisCinema,
                              'Hotel' : hotel == true ? analysisHotel! + 1 : analysisHotel,
                              'Restaurant' : restaurant == true ? analysisRestaurant! + 1 : analysisRestaurant,
                              'Event' : event == true ? analysisEvent! + 1 : analysisEvent,
                              'Game' : game == true ? analysisGame! + 1 : analysisGame,
                              'Gym' : gym == true ? analysisGym! + 1 : analysisGym,
                              'Pool' : pool == true ? analysisPool! + 1 : analysisPool,
                            }).then((value) {
                              setState(() {
                                showSpinner = false;
                              });
                            });
                            Navigator.pushReplacementNamed(context, UserHome.id);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
