import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/inputField/input_form_field.dart';
import 'package:tembea/components/rounded_view_details_button.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/screens/admin/admin_screens/cinema/form/update_cinema_secondary.dart';

import '../../../../../constants.dart';


class UpdateCinemaMain extends StatefulWidget {
  const UpdateCinemaMain({
    Key? key,
    required this.activity,
  }) : super(key: key);
  final DocumentSnapshot activity;

  @override
  _UpdateCinemaMainState createState() => _UpdateCinemaMainState();
}

class _UpdateCinemaMainState extends State<UpdateCinemaMain> {
  String ? name;
  String ? location;
  String ? description;
  String ? price;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();

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
            stream: FirebaseFirestore.instance.collection('activities').doc(widget.activity.reference.id).snapshots(),
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                final activity = snapshot.data!.data();
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InputFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter the value';
                          }
                          return null;
                        },
                        initialValue: activity['Name'],
                        shape: kTopRounded,
                        label: 'Cinema Name*',
                        hintText: 'Enter Cinema Name',
                        maxLines: 1,
                        minLines: 1,
                        onChanged: (value){
                          name = value;
                        },
                      ),
                      InputFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter the value';
                          }
                          return null;
                        },
                        initialValue: activity['Location'],
                        shape: kRoundedBorder,
                        label: 'Cinema Location*',
                        hintText: 'Enter Cinema Location',
                        maxLines: 1,
                        minLines: 1,
                        onChanged: (value){
                          location = value;
                        },
                      ),
                      InputFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter the value';
                          }
                          return null;
                        },
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
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please enter the value';
                            }
                            return null;
                          },
                          initialValue: activity['Description'],
                          shape: kBottomRounded,
                          label: 'Cinema Description*',
                          hintText: 'Enter Cinema Description',
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
                            children: [
                              Expanded(
                                child: RoundedViewDetailsButton(
                                  title: 'Update',
                                  onPressed: () async{
                                    if(_formKey.currentState!.validate()){
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
                                          message: 'Edited Successfully',
                                          color: Colors.green,
                                        );
                                      });
                                    }
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
                                    Navigator
                                        .push(context, MaterialPageRoute(builder: (context){
                                      return UpdateCinemaSecondary(activity: widget.activity);
                                    }));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
