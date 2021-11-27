import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/rounded_button.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/components/square_button.dart';
import 'package:tembea/components/time_pick.dart';
import 'package:tembea/screens/admin/admin_screens/restaurant/form/add_images.dart';

import '../../../../../constants.dart';

class UpdateSecondaryForm extends StatefulWidget {
  const UpdateSecondaryForm({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  final DocumentSnapshot restaurant;


  @override
  _UpdateSecondaryFormState createState() => _UpdateSecondaryFormState();
}

class _UpdateSecondaryFormState extends State<UpdateSecondaryForm> {
  bool showSpinner = false;
  String ? selectedOpeningTime;
  String ? selectedClosingTime;
  String ? selectedTime;
  List<String> imageList =[];
  List<File> files = [];
  List<String> ? imageUrl;
  TaskSnapshot? snap;
  String ? photoUrl;
  String ? photoUrl2;
  String ? photoUrl3;
  String selectedType = 'Restaurant';

  @override
  Widget build(BuildContext context) {
    Future<void> openTimePicker(context) async {
      final TimeOfDay? t =
      await showTimePicker(
          context: context, initialTime: TimeOfDay.now());
      if(t != null){
        setState(() {
          selectedTime = t.format(context);
        });
      }
    }
    goToAddImage() async{
      List<String> imgUrl = await Navigator.push(context, MaterialPageRoute(builder:(context){
        return const AddImages();
      }));
      setState(() {
        imageUrl = imgUrl;
      });
    }
    if(imageUrl?.isNotEmpty == true){
      setState(() {
        photoUrl = imageUrl?[0];
        photoUrl2 = imageUrl?[1];
        photoUrl3 = imageUrl?[2];
        imageList.add(photoUrl!);
        imageList.add(photoUrl2!);
        imageList.add(photoUrl3!);
      });
    }
    return LoadingOverlay(
      isLoading: showSpinner,
      opacity: 0.5,
      color: Colors.green,
      progressIndicator: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.green),
      ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Edit Restaurant'),
            backgroundColor: kBackgroundColor.withOpacity(0.3),
          ),
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('activities').doc(widget.restaurant.reference.id).snapshots(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  final restaurant = snapshot.data!.data();
                  final List<String> defaultImageList = [
                    restaurant['PhotoUrl'],
                    restaurant['PhotoUrl2'],
                    restaurant['PhotoUrl3'],
                  ];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          autoPlay: false,
                        ),
                        items:imageList.isEmpty ? defaultImageList.map((e) => ClipRRect(
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
                        )).toList()
                            : imageList.map((e) => ClipRRect(
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
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          DateButton(
                            text: 'Upload Images',
                            onPressed: () {
                              goToAddImage();
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          TimePick(
                            label: 'Opens at',
                            labelColor: Colors.green,
                            time: selectedOpeningTime ?? restaurant['OpeningTime'],
                            onPressed: (){
                              openTimePicker(context).then((value) {
                                setState(() {
                                  selectedOpeningTime = selectedTime!;
                                });
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TimePick(
                              label: 'Closes at',
                              labelColor: Colors.red,
                              time: selectedClosingTime ?? restaurant['ClosingTime'],
                              onPressed: (){
                                openTimePicker(context).then((value) {
                                  setState(() {
                                    selectedClosingTime = selectedTime!;
                                  });
                                });
                              }
                          ),
                        ],
                      ),
                      RoundedButton(
                          buttonName: 'Update Restaurant',
                          color: Colors.green,
                          onPressed: () async{
                            setState(() {
                              showSpinner = true;
                              selectedOpeningTime ??= restaurant['OpeningTime'];
                              selectedClosingTime ??= restaurant['ClosingTIme'];
                              photoUrl ??= restaurant['PhotoUrl'];
                              photoUrl2 ??= restaurant['PhotoUrl2'];
                              photoUrl3 ??= restaurant['PhotoUrl3'];
                            });
                            final time = DateTime.now();
                            FirebaseStorage.instance.refFromURL(restaurant['PhotoUrl']).delete().then((value) {
                              FirebaseStorage.instance.refFromURL(restaurant['PhotoUrl1']).delete();
                            }).then((value) {
                              FirebaseStorage.instance.refFromURL(restaurant['PhotoUrl2']).delete();
                            }).then((value) {
                              FirebaseFirestore.instance.collection('activities').doc(widget.restaurant.reference.id).update({
                                'OpeningTime' : selectedOpeningTime,
                                'ClosingTime' : selectedClosingTime,
                                'PhotoUrl' : photoUrl,
                                'PhotoUrl2' : photoUrl2,
                                'PhotoUrl3' : photoUrl3,
                                'ts' : time,
                              });
                            }).then((value) {
                              setState(() {
                                showSpinner = false;
                              });
                              showToast(message: 'Restaurant Added',
                                  color: Colors.green,
                              );
                              Navigator.pop(context);
                            });
                          }
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
          ),
        ),
    );
  }
}
