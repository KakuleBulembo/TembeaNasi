import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tembea/components/viewData/bottom_place_view.dart';
import 'package:tembea/screens/admin/admin_screens/event/form/update_main_form.dart';
import '../../../../constants.dart';
import 'package:flutter/foundation.dart';

class ViewData extends StatefulWidget {
   const ViewData({
    Key? key,
    required this.activity,
  }) : super(key: key);
  final DocumentSnapshot activity;
  static String id = 'view_data';

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {

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
            stream: FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                final activity = snapshot.data.data();
                imageUrl.add(activity['PhotoUrl']);
                imageUrl.add(activity['PhotoUrl2']);
                imageUrl.add(activity['PhotoUrl3']);
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
                              activityName: activity['Name'],
                              priceLabel: 'From',
                              price: activity['Price'],
                              activityDescription: activity['Description'],
                              openingTimeLabel: 'Starts',
                              openingTime: DateFormat('dd/MM/yyyy')
                                  .format(DateTime.fromMicrosecondsSinceEpoch(activity['OpeningDate']
                                  .microsecondsSinceEpoch)),
                              closingTimeLabel: 'Ends',
                              closingTime: DateFormat('dd/MM/yyyy')
                                  .format(DateTime.fromMicrosecondsSinceEpoch(activity['EndDate']
                                  .microsecondsSinceEpoch)),
                              location: activity['Location'],
                              labelButton: 'Edit Event',
                              onPressedFormButton: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return UpdateMainForm(activity: widget.activity);
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
