import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/add_images.dart';
import 'package:tembea/components/rounded_button.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/components/square_button.dart';
import 'package:tembea/components/time_pick.dart';

import '../../../../../constants.dart';

class UpdateGymSecondary extends StatefulWidget {
  const UpdateGymSecondary({
    Key? key,
    required this.activity,
  }) : super(key: key);
  final DocumentSnapshot activity;

  @override
  _UpdateGymSecondaryState createState() => _UpdateGymSecondaryState();
}

class _UpdateGymSecondaryState extends State<UpdateGymSecondary> {
  bool showSpinner = false;
  String ? selectedOpeningTime;
  String ? selectedClosingTime;
  String ? selectedTime;
  List<String> imageList =[];
  List<String> ? imageUrl;
  TaskSnapshot? snap;
  String ? photoUrl;
  String ? photoUrl2;
  String ? photoUrl3;

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
            stream: FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).snapshots(),
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                final activity = snapshot.data!.data();
                final List<String> defaultImageList = [
                  activity['PhotoUrl'],
                  activity['PhotoUrl2'],
                  activity['PhotoUrl3'],
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
                          time: selectedOpeningTime ?? activity['OpeningTime'],
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
                            time: selectedClosingTime ?? activity['ClosingTime'],
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
                        buttonName: 'Update Game',
                        color: Colors.green,
                        onPressed: () async{
                          setState(() {
                            showSpinner = true;
                            selectedOpeningTime ??= activity['OpeningTime'];
                            selectedClosingTime ??= activity['ClosingTime'];
                            photoUrl ??= activity['PhotoUrl'];
                            photoUrl2 ??= activity['PhotoUrl2'];
                            photoUrl3 ??= activity['PhotoUrl3'];
                          });
                          final time = DateTime.now();
                          if(imageList.isNotEmpty) {
                            FirebaseStorage.instance.refFromURL(activity['PhotoUrl']).delete().then((value) {
                              FirebaseStorage.instance.refFromURL(activity['PhotoUrl2']).delete();
                            }).then((value) {
                              FirebaseStorage.instance.refFromURL(activity['PhotoUrl3']).delete();
                            }).then((value) {
                              FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).update({
                                'OpeningTime' : selectedOpeningTime,
                                'ClosingTime' : selectedClosingTime,
                                'PhotoUrl' : photoUrl,
                                'PhotoUrl2' : photoUrl2,
                                'PhotoUrl3' : photoUrl3,
                                'ts' : time,
                              }).then((value) {
                                setState(() {
                                  showSpinner = false;
                                });
                                showToast(message: 'Game Updated',
                                  color: Colors.green,
                                );
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            });

                          }
                          else {
                            FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).update({
                              'OpeningTime' : selectedOpeningTime,
                              'ClosingTime' : selectedClosingTime,
                              'ts' : time,
                            }).then((value) {
                              setState(() {
                                showSpinner = false;
                              });
                              showToast(message: 'Gym Updated',
                                color: Colors.green,
                              );
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          }
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
