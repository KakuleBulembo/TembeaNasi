import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/inputField/input_form_field.dart';
import 'package:tembea/components/rounded_view_details_button.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/screens/admin/admin_screens/restaurant/form/restaurant_secondary_form.dart';
import '../../../../../constants.dart';

class RestaurantMainForm extends StatefulWidget {
  const RestaurantMainForm({Key? key}) : super(key: key);
  static String id = 'restaurant_main_form';

  @override
  _RestaurantMainFormState createState() => _RestaurantMainFormState();
}

class _RestaurantMainFormState extends State<RestaurantMainForm> {
  late String name;
  late String location;
  late String description;
  late String price;
  bool showSpinner = false;
  List<String>? data;
  String ? photoUrl;
  String ? photoUrl2;
  String ? photoUrl3;
  String selectedType = 'Restaurant';
  String ? openingTime;
  String ? closingTime;

  goToSecondaryForm() async{
    List<String> secondaryData = await Navigator.push(context, MaterialPageRoute(builder:(context){
      return const RestaurantSecondaryForm();
    }));
    setState(() {
      data = secondaryData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(data?.isNotEmpty == true){
      setState(() {
        openingTime = data?[0];
        closingTime = data?[1];
        photoUrl = data?[2];
        photoUrl2 = data?[3];
        photoUrl3 = data?[4];
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
          title: Text(
              'Add Restaurant'.toUpperCase()
          ),
          backgroundColor: kBackgroundColor.withOpacity(0.3),
        ),
        body: Padding(
          padding:  const EdgeInsets.only(
            top: 40,
            bottom: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InputFormField(
                shape: kTopRounded,
                label: 'Restaurant Name*',
                hintText: 'Enter Restaurant Name',
                maxLines: 1,
                minLines: 1,
                onChanged: (value){
                  name = value;
                },
              ),
              InputFormField(
                shape: kRoundedBorder,
                  label: 'Restaurant Location*',
                  hintText: 'Enter Restaurant Location',
                  maxLines: 1,
                  minLines: 1,
                  onChanged: (value){
                    location = value;
                  },
              ),
              InputFormField(
                shape: kRoundedBorder,
                label: 'Minimum Price*',
                hintText: 'Enter Minimum Price',
                maxLines: 1,
                minLines: 1,
                onChanged: (value){
                  price = value;
                },
              ),
              GestureDetector(
                onTap:  () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  }
                },
                child: InputFormField(
                  shape: kBottomRounded,
                  label: 'Restaurant Description*',
                  hintText: 'Enter Restaurant Description',
                  maxLines: 7,
                  minLines: 4,
                  onChanged: (value){
                    description = value;
                  },
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding:const EdgeInsets.all(20),
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: kSecondaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RoundedViewDetailsButton(
                            title: 'Create',
                            onPressed: () async{
                              DateTime time = DateTime.now();
                              data?.isNotEmpty == true ? await FirebaseFirestore.instance.collection('activities').doc().set({
                                'Name' : name,
                                'Location' : location,
                                'Price' : price,
                                'Description' : description,
                                'OpeningTime' : openingTime,
                                'ClosingTime' : closingTime,
                                'Type' : selectedType,
                                'PhotoUrl' : photoUrl,
                                'PhotoUrl2' : photoUrl2,
                                'PhotoUrl3' : photoUrl3,
                                'ts' : time,
                              }).then((value) {
                                setState(() {
                                  showSpinner = false;
                                });
                                Navigator.pop(context);
                                showToast(
                                  message: 'Restaurant Edited Successfully',
                                  color: Colors.green,
                                );
                              }) : null;
                            },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RoundedViewDetailsButton(
                            title: 'Next>',
                            onPressed: (){
                              goToSecondaryForm();
                            },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
