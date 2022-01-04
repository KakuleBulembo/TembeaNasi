import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/inputField/input_form_field.dart';
import 'package:tembea/components/rounded_view_details_button.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/screens/admin/admin_screens/event/form/update_secondary_form.dart';

import '../../../../../constants.dart';

class UpdateMainForm extends StatefulWidget {
  const UpdateMainForm({
    Key? key,
    required this.activity
  }) : super(key: key);
  final DocumentSnapshot activity;

  @override
  _UpdateMainFormState createState() => _UpdateMainFormState();
}

class _UpdateMainFormState extends State<UpdateMainForm> {
  String ? name;
  String ? location;
  String ? description;
  String ? price;
  bool showSpinner = false;
  List<String>? data;
  String ? photoUrl;
  String ? photoUrl2;
  String ? photoUrl3;
  String selectedType = 'Event';
  String ? openingTime;
  String ? closingTime;

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
              'Add Event'.toUpperCase()
          ),
          backgroundColor: kBackgroundColor.withOpacity(0.3),
        ),
        body: Padding(
          padding:  const EdgeInsets.only(
            top: 40,
            bottom: 40,
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).snapshots(),
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                final activity = snapshot.data.data();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputFormField(
                      initialValue: activity['Name'],
                      shape: kTopRounded,
                      label: 'Event Name*',
                      hintText: 'Enter Event Name',
                      maxLines: 1,
                      minLines: 1,
                      onChanged: (value){
                        name = value;
                      },
                    ),
                    InputFormField(
                      initialValue: activity['Location'],
                      shape: kRoundedBorder,
                      label: 'Event Location*',
                      hintText: 'Enter Event Location',
                      maxLines: 1,
                      minLines: 1,
                      onChanged: (value){
                        location = value;
                      },
                    ),
                    InputFormField(
                      initialValue: activity['Price'],
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
                        initialValue: activity['Description'],
                        shape: kBottomRounded,
                        label: 'Event Description*',
                        hintText: 'Enter Event Description',
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
                                title: 'Update',
                                onPressed: () async{
                                  setState(() {
                                    showSpinner = true;
                                    name ??= activity['Name'];
                                    location ??= activity['Location'];
                                    price ??= activity['Price'];
                                    description ??= activity['Description'];
                                  });
                                  await FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).update({
                                    'Name' : name,
                                    'Location' : location,
                                    'Price' : price,
                                    'Description' : description,
                                  }).then((value) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    Navigator.pop(context);
                                    showToast(
                                      message: 'Event Edited Successfully',
                                      color: Colors.green,
                                    );
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: RoundedViewDetailsButton(
                                title: 'Next>',
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return UpdateSecondaryForm(activity: widget.activity);
                                  }));
                                },
                              ),
                            ),
                          ],
                        ),
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
        ),
      ),
    );
  }
}
