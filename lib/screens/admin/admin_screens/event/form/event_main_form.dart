import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/inputField/input_form_field.dart';
import 'package:tembea/components/rounded_view_details_button.dart';


import '../../../../../constants.dart';
import 'event_secondary_form.dart';

class EventMainForm extends StatefulWidget {
  const EventMainForm({
    Key? key
  }) : super(key: key);
  static String id = 'event_main_form';

  @override
  _EventMainFormState createState() => _EventMainFormState();
}

class _EventMainFormState extends State<EventMainForm> {
  late String name;
  late String location;
  late String description;
  late String price;
  bool showSpinner = false;
  String ? photoUrl;
  String ? photoUrl2;
  String ? photoUrl3;
  String selectedType = 'Event';
  String ? openingTime;
  String ? closingTime;
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
          child: Form(
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
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter the value';
                    }
                    return null;
                  },
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
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter the value';
                    }
                    return null;
                  },
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
                            title: 'Next>',
                            onPressed: (){
                              if(_formKey.currentState!.validate()){
                                Navigator.push(context, MaterialPageRoute(builder:(context){
                                  return EventSecondaryForm(
                                    name: name,
                                    location: location,
                                    price: price,
                                    description: description,
                                  );
                                }));
                              }
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
      ),
    );
  }
}
