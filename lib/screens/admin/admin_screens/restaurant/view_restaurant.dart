import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tembea/components/viewData/bottom_place_view.dart';
import 'package:tembea/screens/admin/admin_screens/restaurant/form/update_main_form.dart';
import 'package:tembea/screens/admin/admin_screens/restaurant/form/update_secondary_form.dart';

import '../../../../constants.dart';

class ViewRestaurant extends StatefulWidget {
  const ViewRestaurant({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  final DocumentSnapshot restaurant;

  @override
  _ViewRestaurantState createState() => _ViewRestaurantState();
}

class _ViewRestaurantState extends State<ViewRestaurant> {
  List<String> imageUrl = [];
  final List<String> defaultImageList = [
    'assets/images/image.png',
    'assets/images/image.png',
    'assets/images/image.png',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title:const Text('Tembea Nasi'),
          backgroundColor: kBackgroundColor,
        ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('activities').doc(widget.restaurant.reference.id).snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
               if(snapshot.hasData){
                 final restaurant = snapshot.data.data();
                 imageUrl.add(restaurant['PhotoUrl']);
                 imageUrl.add(restaurant['PhotoUrl2']);
                 imageUrl.add(restaurant['PhotoUrl3']);
                 return Column(
                   children: [
                      SizedBox(
                       height: size.height,
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.12,
                                  left: 8.0,
                                  right: 8.0
                              ),
                              margin: EdgeInsets.only(top: size.height * 0.3),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.3),
                                borderRadius:const BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24)
                                ),
                              ),
                              child: BottomPlaceView(
                                activityName: restaurant['Name'],
                                activityDescription: restaurant['Description'],
                                openingTime: restaurant['OpeningTime'],
                                closingTime: restaurant['ClosingTime'],
                                location: restaurant['Location'],
                                labelButton: 'Edit Restaurant',
                                onPressedFormButton: (){
                                  Navigator
                                      .push(context, MaterialPageRoute(builder: (context){
                                    return UpdateMainForm(restaurant: widget.restaurant);
                                  }));
                                },
                                onPressedImageButton: (){
                                  Navigator
                                  .push(context, MaterialPageRoute(builder: (context){
                                    return UpdateSecondaryForm(restaurant: widget.restaurant);
                                  }));
                                },
                              ),
                            ),
                            Padding(
                              padding:const EdgeInsets.only(
                                top: 20,
                                left: 20,
                                right: 20,
                              ),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: false,
                                  autoPlay: false,
                                ),
                                items: imageUrl.isEmpty ? defaultImageList.map((e) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.asset(
                                        e,
                                        width: 1000,
                                        height: 300,
                                        fit: BoxFit.fill,
                                      )
                                    ],
                                  ),
                                )).toList()
                                    : imageUrl.map((e) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.network(
                                        e,
                                        width: 1000,
                                        height: 300,
                                        fit: BoxFit.fill,
                                      )
                                    ],
                                  ),
                                )).toList(),
                              ),
                            ),

                          ],
                        ),
                     ),
                   ],
                 );
               }
               else{
                 return const CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(Colors.green),
                 );
               }
            },
        ),
      )
    );
  }
}

