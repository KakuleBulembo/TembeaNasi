import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/rounded_button.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/components/time_pick.dart';
import 'package:tembea/components/add_images.dart';
import '../../../../../constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tembea/components/square_button.dart';
import 'dart:io';


class EventSecondaryForm extends StatefulWidget {
  const EventSecondaryForm({
    Key? key,
    required this.name,
    required this.location,
    required this.price,
    required this.description,
  }) : super(key: key);
  final String name;
  final String location;
  final String price;
  final String description;


  @override
  _EventSecondaryFormState createState() => _EventSecondaryFormState();
}

class _EventSecondaryFormState extends State<EventSecondaryForm> {
  DateTimeRange ? dateRange;
  bool showSpinner = false;
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
  int numberOfRatings = 0;
  int avgRating = 0;

  goToAddImage() async{
    List<String> imgUrl = await Navigator.push(context, MaterialPageRoute(builder:(context){
      return const AddImages();
    }));
    setState(() {
      imageUrl = imgUrl;
    });
  }
  String selectedType = 'Event';
  String getFrom(){
    if(dateRange == null){
      return 'Select date';
    }
    else{
      return DateFormat('dd/MM/yyyy').format(dateRange!.start);
    }
  }
  String getUntil(){
    if(dateRange == null){
      return 'Select date';
    }
    else{
      return DateFormat('dd/MM/yyyy').format(dateRange!.end);
    }
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
                    label: 'Starts ',
                    labelColor: Colors.green,
                    time: getFrom(),
                    onPressed: (){
                      pickDateRange(context);
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
                        pickDateRange(context);
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
                      secondaryData.add(photoUrl!);
                      secondaryData.add(photoUrl2!);
                      secondaryData.add(photoUrl3!);
                    });
                    if(imageList.isNotEmpty && dateRange != null){
                      await FirebaseFirestore.instance.collection('activities').doc().set({
                        'Name' : widget.name,
                        'Location' : widget.location,
                        'Price' : widget.price,
                        'Description' : widget.description,
                        'OpeningDate' : dateRange!.start,
                        'EndDate' : dateRange!.end,
                        'Type' : selectedType,
                        'PhotoUrl' : photoUrl,
                        'PhotoUrl2' : photoUrl2,
                        'PhotoUrl3' : photoUrl3,
                        'numberOfRatings' : numberOfRatings,
                        'avgRating' : avgRating,
                        'ts' : DateTime.now(),
                      }).then((value) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        showToast(message: 'Added Successfully', color: Colors.green);
                      });
                    }
                    else{
                      null;
                    }
                  }
              ),
            ],
          ),
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
