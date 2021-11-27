import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/rounded_button.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/components/time_pick.dart';
import '../../../../../constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tembea/components/square_button.dart';
import 'dart:io';
import 'add_images.dart';

class RestaurantSecondaryForm extends StatefulWidget {
  const RestaurantSecondaryForm({
    Key? key,
  }) : super(key: key);

  @override
  _RestaurantSecondaryFormState createState() => _RestaurantSecondaryFormState();
}

class _RestaurantSecondaryFormState extends State<RestaurantSecondaryForm> {
  bool showSpinner = false;
  String selectedOpeningTime = '8:00 AM';
  String selectedClosingTime = '17:00 PM';
  String ? selectedTime;
  final List<String> defaultImageList = [
    'assets/images/image.png',
    'assets/images/image.png',
    'assets/images/image.png',
  ];
  List<String> imageList =[];
  List<File> files = [];
  List<String> secondaryData = [];
  List<String> ? imageUrl;
  String ? photoUrl;
  String ? photoUrl2;
  String ? photoUrl3;

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
        photoUrl = '';
        photoUrl2 = '';
        photoUrl3 = '';
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
            title: const Text('Add Restaurant'),
            backgroundColor: kBackgroundColor.withOpacity(0.3),
          ),
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
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
                          Image.asset(
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
                      time: selectedOpeningTime,
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
                        time: selectedClosingTime,
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
                    buttonName: 'Add More',
                    color: Colors.green,
                    onPressed: () async{
                      setState(() {
                        showSpinner = true;
                        secondaryData.add(selectedOpeningTime);
                        secondaryData.add(selectedClosingTime);
                        secondaryData.add(photoUrl!);
                        secondaryData.add(photoUrl2!);
                        secondaryData.add(photoUrl3!);
                      });
                      Navigator.pop(context, secondaryData);
                      showToast(message: 'Added Successfully', color: Colors.green);
                    }
                ),
              ],
            ),
          ),
        ),
    );
  }
}

