import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/components/square_button.dart';
import 'package:tembea/constants.dart';
import 'package:intl/intl.dart';
import 'package:tembea/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:tembea/screens/admin/admin_components/date_function.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Update Event'),
        backgroundColor: kBackgroundColor.withOpacity(0.3),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
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
                    TextFormField(
                      initialValue: widget.item['Name'],
                      textAlign: TextAlign.center,
                      cursorColor: Colors.blue,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration:  kActivityForm.copyWith(
                          labelText: 'Event\'s Name'
                      ),
                      onChanged: (value){
                          name = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.item['Location'],
                      textAlign: TextAlign.center,
                      cursorColor: Colors.blue,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration:  kActivityForm.copyWith(
                          labelText: 'Event\'s Location'
                      ),
                      onChanged: (value){
                        location = value;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      initialValue: widget.item['Description'],
                        textAlign: TextAlign.center,
                        cursorColor: Colors.blue,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration:  kActivityForm.copyWith(
                          labelText: 'Event\'s description',
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          isDense: true,
                        ),
                        maxLines: 7,
                        minLines: 4,
                        onChanged: (value){
                          description = value;
                        }
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.item['Price'],
                        textAlign: TextAlign.center,
                        cursorColor: Colors.blue,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration:  kActivityForm.copyWith(
                          labelText: 'Event\'s participation price',
                        ),
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
                              name ??= widget.item['Name'];
                              location ??= widget.item['Location'];
                              description ??= widget.item['Description'];
                              price ??= widget.item['Price'];
                              date ??= widget.item['Date'].toDate();
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
                              Navigator.pop(context);
                            });
                        },
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
