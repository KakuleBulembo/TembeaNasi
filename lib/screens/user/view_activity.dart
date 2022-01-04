import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tembea/components/custom_text_button.dart';
import 'package:tembea/components/inputField/square_input_text_field.dart';
import 'package:tembea/components/rounded_view_details_button.dart';
import 'package:tembea/components/show_toast.dart';
import '../../constants.dart';

class ViewActivity extends StatefulWidget {
  const ViewActivity({
    Key? key,
    required this.activity,
  }) : super(key: key);
  final DocumentSnapshot activity;

  @override
  _ViewActivityState createState() => _ViewActivityState();
}

class _ViewActivityState extends State<ViewActivity> {
  List<String> imageUrl = [];
  double rating = 0;
  User? currentUser = FirebaseAuth.instance.currentUser;
  String comment = '';
  double avgRating = 0;
  double numberOfRatings = 0;
  double totalRatings = 0;
  double totalUsers = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(IconData(57492, fontFamily: 'MaterialIcons'), color: Colors.green),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Tembea Nasi',
            style: GoogleFonts.pacifico(
              textStyle:const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 1.5
              ),
            ),
          ),
          backgroundColor: kBackgroundColor,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).snapshots(),
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              final activity = snapshot.data.data();
              imageUrl.add(activity['PhotoUrl']);
              imageUrl.add(activity['PhotoUrl2']);
              imageUrl.add(activity['PhotoUrl3']);
                avgRating = activity['avgRating'].toDouble();
                numberOfRatings = activity['numberOfRatings'].toDouble();
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:const EdgeInsets.all(16),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          autoPlay: true,
                        ),
                        items: imageUrl.map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                e,
                                width: size.width * 0.75,
                                height: size.height * 0.25,
                                fit: BoxFit.fill,
                              )
                            ],
                          ),
                        )).toList(),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Center(
                      child: Text(
                        activity['Name'],
                        style: GoogleFonts.abhayaLibre(
                          textStyle: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          activity['Type'],
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.green.withOpacity(0.7),
                            )
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 30,
                          width: 3,
                          color: Colors.green.withOpacity(0.5),
                          child:const Text(''),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          numberOfRatings != 0 ? 'Rating: ${avgRating/numberOfRatings}' : 'Rating: 0',
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.green.withOpacity(0.7),
                              ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        'From: ${activity['Price']}Ksh',
                        style: GoogleFonts.pacifico(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blue.withOpacity(0.7),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: SizedBox(
                        height: size.height * 0.13,
                        child: SingleChildScrollView(
                          child: Text(
                            activity['Description'],
                            style: GoogleFonts.abhayaLibre(
                              textStyle:const TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                activity['Type'] == 'Event' ? 'Starts' : 'Opens',
                                style: GoogleFonts.aBeeZee(
                                  textStyle:const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                  activity['Type'] == 'Event' ? DateFormat('dd/MM/yyyy')
                                      .format(DateTime.fromMicrosecondsSinceEpoch(activity['OpeningDate']
                                      .microsecondsSinceEpoch)) : activity['OpeningTime'],
                                style: GoogleFonts.acme(
                                  textStyle:const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                activity['Type'] == 'Event' ? 'Ends' : 'Closes',
                                style: GoogleFonts.aBeeZee(
                                  textStyle:const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                activity['Type'] == 'Event' ? DateFormat('dd/MM/yyyy')
                                    .format(DateTime.fromMicrosecondsSinceEpoch(activity['EndDate']
                                    .microsecondsSinceEpoch)) : activity['ClosingTime'],
                                style: GoogleFonts.acme(
                                  textStyle:const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          IconData(0xe3ab, fontFamily: 'MaterialIcons'),
                          color: Colors.deepOrange,
                        ),
                        Text(activity['Location'],
                          style: GoogleFonts.abhayaLibre(
                            textStyle: TextStyle(
                              color: Colors.deepOrange.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Container(
                      width: size.width * 0.9,
                      padding:const EdgeInsets.all(10),
                      decoration:const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: kSecondaryColor,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: RoundedViewDetailsButton(
                              title: 'More',
                              onPressed: (){},
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: RoundedViewDetailsButton(
                              title: 'Rate',
                              onPressed: () async{
                                Future<DocumentSnapshot<Map<String, dynamic>>> subSnapshot = FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).collection('rating').doc(currentUser!.uid).get();
                                DocumentSnapshot doc = await subSnapshot;
                                if(doc.exists){
                                  showToast(message: 'Already Rated', color: Colors.red);
                                }
                                else{
                                  showRating();
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                primary: kBackgroundColor,
                                padding: const EdgeInsets.symmetric(horizontal: 10.0 * 1.5, vertical: 16.0),
                              ),
                              child: const Icon(Icons.phone),
                              onPressed: (){},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            else{
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.green),
              );
            }
          },
        ),
    );
  }
  Widget buildRating(){
    return RatingBar.builder(
      minRating: 1,
        itemBuilder: (context, _){
           return const Icon(Icons.star, color: Colors.amber,);
        },
        onRatingUpdate: (rating){
           return setState(() {
             this.rating = rating;
           });
        }
    );
  }
  void showRating() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: const  RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          backgroundColor: kBackgroundColor,
          title: const Text(
              'Rate this activity',
              style:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                fontSize: 25,
              )
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Please leave a rating',
                style: GoogleFonts.abhayaLibre(
                  textStyle:const TextStyle(
                    fontSize: 23,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              buildRating(),
              SquareInputTextField(
                initialValue: '',
                labelText: 'Please leave a comment',
                onChanged: (value) {
                   setState(() {
                     comment = value;
                   });
                },
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  text: 'cancel',
                  color: Colors.red,
                ),
                CustomTextButton(
                  onPressed: () async{
                    if(comment.isNotEmpty && rating > 0){
                      totalRatings = avgRating + rating;
                      totalUsers = numberOfRatings + 1;
                      await FirebaseFirestore.instance.collection('activities')
                          .doc(widget.activity.reference.id).collection('rating')
                          .doc(currentUser!.uid).set({
                        'userId' : currentUser!.uid,
                        'rating' : rating,
                        'comment' : comment,
                      }).then((value) {
                        FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id)
                            .update({
                          'avgRating' :  totalRatings,
                          'numberOfRatings' : totalUsers,
                        });
                        showToast(
                          message: 'Rating Added',
                          color: Colors.green,
                        );
                      });
                      Navigator.pop(context);
                    }
                    else{
                      if(rating == 0){
                        showToast(message: 'Please Enter a rating', color: Colors.red);
                      }
                      else{
                        showToast(message: 'Please Enter A comment', color: Colors.red);
                      }
                    }
                  },
                  text: 'send',
                  color: Colors.green,
                ),
              ],
            )
          ],
        ),
    );
  }
}