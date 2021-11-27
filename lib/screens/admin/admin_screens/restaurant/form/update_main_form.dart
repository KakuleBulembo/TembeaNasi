import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/inputField/input_form_field.dart';
import 'package:tembea/components/rounded_button.dart';
import 'package:tembea/components/show_toast.dart';
import '../../../../../constants.dart';

class UpdateMainForm extends StatefulWidget {
  const UpdateMainForm({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  final DocumentSnapshot restaurant;

  @override
  _UpdateMainFormState createState() => _UpdateMainFormState();
}

class _UpdateMainFormState extends State<UpdateMainForm> {
  String ? name;
  String ? location;
  String ? description;
  String ? price;
  bool showSpinner = false;

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
          title: const Text('Update Activity'),
          backgroundColor: kBackgroundColor.withOpacity(0.3),
        ),
        body: Padding(
          padding:  const EdgeInsets.only(
            top: 40,
            bottom: 40,
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('activities').doc(widget.restaurant.reference.id).snapshots(),
            builder: (context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                final restaurant = snapshot.data!.data();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputFormField(
                      initialValue: restaurant['Name'],
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
                      initialValue: restaurant['Location'],
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
                      initialValue: restaurant['Price'],
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
                        initialValue: restaurant['Description'],
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
                    RoundedButton(
                      buttonName: 'Update Restaurant',
                      color: Colors.green,
                      onPressed: () async{
                        setState(() {
                          showSpinner = true;
                          name ??= restaurant['Name'];
                          location ??= restaurant['Location'];
                          price ??= restaurant['Price'];
                          description ??= restaurant['Description'];
                        });

                       await FirebaseFirestore.instance.collection('activities').doc(widget.restaurant.reference.id).update({
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
                             message: 'Restaurant Edited Successfully',
                             color: Colors.green,
                         );

                       });
                      },
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

