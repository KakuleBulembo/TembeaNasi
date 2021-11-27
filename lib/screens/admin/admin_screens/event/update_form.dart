import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/inputField/description_text_field.dart';
import 'package:tembea/components/inputField/square_input_text_field.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/components/square_button.dart';
import 'package:tembea/constants.dart';
import 'package:intl/intl.dart';
import 'package:tembea/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:tembea/screens/admin/admin_components/date_function.dart';


class UpdateForm extends StatefulWidget {
  const UpdateForm({
    Key?key,
    required this.item
  }) : super(key: key);
  static String id = 'event_form';
  final DocumentSnapshot item;

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  DateTime ? date;
  Timestamp ? dateTim;
  String selectedType = 'Event';
  String getText() {
    if (date == null){
      return  DateFormat('dd/MM/yyyy HH:mm')
          .format(widget.item['Date'].toDate());
    }
    else{
      return DateFormat('dd/MM/yyyy HH:mm').format(date!);
    }
  }
  String? name;
  String? location;
  String? description;
  String? price;
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
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          title: const Text('Update Event'),
          backgroundColor: kBackgroundColor.withOpacity(0.3),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('activities').doc(widget.item.reference.id).snapshots(),
              builder: (context,AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  final event = snapshot.data!.data();
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 30, left: 30, right: 30.0, bottom: 30),
                        decoration: const BoxDecoration(
                          color: kSecondaryColor,
                        ),
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            SquareInputTextField(
                              initialValue: event['Name'],
                              labelText: 'Event\'s Name',
                              onChanged: (value){
                                name = value;
                              },
                            ),
                            SquareInputTextField(
                              initialValue: event['Location'],
                              labelText: 'Event\'s Location',
                              onChanged: (value){
                                location = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DescriptionTextField(
                              initialValue: event['Description'],
                              description: 'Event\'s description',
                              onChanged: (value){
                                description = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SquareInputTextField(
                                initialValue: event['Price'],
                                labelText: 'Event\'s participation price',
                                onChanged: (value){
                                  price = value;
                                }
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            DateButton(
                              onPressed: (){
                                pickDateTime(context);
                              },
                              text: getText(),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),

                            Center(
                              child: RoundedButton(
                                buttonName: 'Update Event',
                                onPressed: () async{
                                  DateTime time = DateTime.now();
                                  setState(() {
                                    showSpinner = true;
                                    name ??= event['Name'];
                                    location ??= event['Location'];
                                    description ??= event['Description'];
                                    price ??= event['Price'];
                                    date ??= event['Date'].toDate();
                                  });
                                  await FirebaseFirestore.instance.collection('activities').doc(widget.item.reference.id).update({
                                    'Name': name,
                                    'Location': location,
                                    'Description': description,
                                    'Price': price,
                                    'Date': date,
                                    'Type': selectedType,
                                    'ts': time,
                                  }).then((value) => showToast(
                                    message: "Events Updated Successfully",
                                    color: Colors.green,
                                  )).then((value) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    Navigator.pop(context);
                                  });
                                  setState(() {
                                    showSpinner = false;
                                  });
                                },
                                color: Colors.green,
                              ),
                            ),
                          ],
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
              }
            ),
          ),
        ),
      ),
    );
  }
  Future pickDateTime(BuildContext context) async{
    final chosenDate = await pickDate(context);
    if(chosenDate == null) return ;
    final chosenTime = await pickTime(context);
    if(chosenTime == null) return;
    setState(() {
      if (chosenTime == null && chosenDate == null){
        date = widget.item['Date'];
      }
      else{
        date = DateTime(
          chosenDate.year,
          chosenDate.month,
          chosenDate.day,
          chosenTime.hour,
          chosenTime.minute,
        );
      }
    });
  }
}
