import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/add_images.dart';
import 'package:tembea/components/rounded_button.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/components/square_button.dart';
import 'package:tembea/components/time_pick.dart';

import '../../../../../constants.dart';

class UpdateSecondaryForm extends StatefulWidget {
  const UpdateSecondaryForm({
    Key? key,
    required this.activity,
  }) : super(key: key);
  final DocumentSnapshot activity;

  @override
  _UpdateSecondaryFormState createState() => _UpdateSecondaryFormState();
}

class _UpdateSecondaryFormState extends State<UpdateSecondaryForm> {
  DateTimeRange ? dateRange;
  bool showSpinner = false;
  List<String> imageList =[];
  List<File> files = [];
  List<String> ? imageUrl;
  String ? photoUrl;
  String ? photoUrl2;
  String ? photoUrl3;
  DateTime ? selectedOpeningDate;
  DateTime ? selectedClosingDate;

  goToAddImage() async{
    List<String> imgUrl = await Navigator.push(context, MaterialPageRoute(builder:(context){
      return const AddImages();
    }));
    setState(() {
      imageUrl = imgUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
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
    else{
      setState(() {
        photoUrl = null;
        photoUrl2 = null;
        photoUrl3 = null;
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Update Event'),
          backgroundColor: kBackgroundColor.withOpacity(0.3),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).snapshots(),
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                final activity = snapshot.data.data();
                final List<String> defaultImageList = [
                  activity['PhotoUrl'],
                  activity['PhotoUrl2'],
                  activity['PhotoUrl3'],
                ];
                String getFrom(){
                  if(dateRange == null){
                    return DateFormat('dd/MM/yyyy')
                        .format(DateTime.fromMicrosecondsSinceEpoch(activity['OpeningDate']
                        .microsecondsSinceEpoch));
                  }
                  else{
                    return DateFormat('dd/MM/yyyy').format(dateRange!.start);
                  }
                }
                String getUntil(){
                  if(dateRange == null){
                    return DateFormat('dd/MM/yyyy')
                        .format(DateTime.fromMicrosecondsSinceEpoch(activity['EndDate']
                        .microsecondsSinceEpoch));
                  }
                  else{
                    return DateFormat('dd/MM/yyyy').format(dateRange!.end);
                  }
                }
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
                          label: 'Starts ',
                          labelColor: Colors.green,
                          time: getFrom(),
                          onPressed: (){
                            pickDateRange(context).then((value) {
                              selectedOpeningDate = dateRange!.start;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TimePick(
                            label: 'Ends   ',
                            labelColor: Colors.red,
                            time: getUntil(),
                            onPressed: (){
                              pickDateRange(context).then((value) {
                                selectedClosingDate = dateRange!.end;
                              });
                            }
                        ),
                      ],
                    ),
                    RoundedButton(
                        buttonName: 'Add More',
                        color: Colors.green,
                        onPressed: () async{
                          setState(() {
                            showSpinner = true;
                           selectedOpeningDate ??= activity['OpeningDate'].toDate();
                           selectedClosingDate ??= activity['EndDate'].toDate();
                           photoUrl ??= activity['PhotoUrl'];
                           photoUrl2 ??= activity['PhotoUrl2'];
                           photoUrl3 ??= activity['PhotoUrl3'];
                          });
                          if(imageList.isNotEmpty){
                            FirebaseStorage.instance.refFromURL(activity['PhotoUrl']).delete().then((value) {
                              FirebaseStorage.instance.refFromURL(activity['PhotoUrl2']).delete();
                            }).then((value) {
                              FirebaseStorage.instance.refFromURL(activity['PhotoUrl3']).delete();
                            }).then((value) {
                               FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).update({
                                'OpeningDate' : selectedOpeningDate,
                                'EndDate' : selectedClosingDate,
                                'PhotoUrl' : photoUrl,
                                'PhotoUrl2' : photoUrl2,
                                'PhotoUrl3' : photoUrl3,
                                'ts' : DateTime.now(),
                              }).then((value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                showToast(message: 'Edited Successfully', color: Colors.green);
                              });
                            });
                          }
                          else if(imageList.isEmpty && dateRange != null) {
                            FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).update({
                              'OpeningDate' : selectedOpeningDate,
                              'EndDate' : selectedClosingDate,
                              'ts' : DateTime.now(),
                            }).then((value) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              showToast(message: 'Edited Successfully', color: Colors.green);
                            });
                          }
                          else{
                            null;
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
          )
        ),
      ),
    );
  }
  Future pickDateRange(BuildContext context) async{
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );
    if (newDateRange == null) return;
    setState(() {
      dateRange = newDateRange;
    });
  }
}
