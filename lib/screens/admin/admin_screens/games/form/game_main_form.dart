import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/inputField/input_form_field.dart';
import 'package:tembea/components/rounded_view_details_button.dart';

import '../../../../../constants.dart';
import 'game_secondory_form.dart';

class GameMainForm extends StatefulWidget {
  const GameMainForm({
    Key? key,
  }) : super(key: key);
  static String id = 'game_main_form';

  @override
  _GameMainFormState createState() => _GameMainFormState();
}

class _GameMainFormState extends State<GameMainForm> {
  late String name;
  late String location;
  late String description;
  late String price;
  bool showSpinner = false;
  List<String>? data;
  String ? photoUrl;
  String ? photoUrl2;
  String ? photoUrl3;
  String ? openingTime;
  String ? closingTime;

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
              'Add Game'.toUpperCase()
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
                label: 'Game Name*',
                hintText: 'Enter Game Name',
                maxLines: 1,
                minLines: 1,
                onChanged: (value){
                  name = value;
                },
              ),
              InputFormField(
                shape: kRoundedBorder,
                label: 'Game Location*',
                hintText: 'Enter Game Location',
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
                  label: 'Game Description*',
                  hintText: 'Enter Game Description',
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
                            Navigator.push(context, MaterialPageRoute(builder:(context){
                              return GameSecondaryForm(
                                name: name,
                                location: location,
                                price: price,
                                description: description,
                              );
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
        ),
      ),
    );
  }
}
