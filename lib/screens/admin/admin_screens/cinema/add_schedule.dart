import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tembea/components/rounded_card_date.dart';
import 'package:tembea/components/rounded_card_input.dart';
import 'package:tembea/components/rounded_view_details_button.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/constants.dart';
import 'package:tembea/screens/admin/admin_components/date_function.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({
    Key? key,
    required this.cinemaId,
  }) : super(key: key);
  final String cinemaId;

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final _formKey = GlobalKey<FormState>();
  DateTime ? date;
  String getDate(){
    if(date == null){
      return 'Select Date and Time';
    }
    else{
      return DateFormat('dd/MM/yyyy HH:mm').format(date!);
    }
  }
  late String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie Weekly Program',
          style: GoogleFonts.acme(
            textStyle:const TextStyle(
                fontSize: 25,
                color: Colors.white
            ),
          ),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            RoundedCardInput(
              title: 'Movie Name',
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            RoundedCardDate(
              title: 'Date and Time',
              text: getDate(),
              onPressed: (){
                pickDateTime(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: RoundedViewDetailsButton(
                        title: 'Add Program',
                        onPressed: () async{
                          if(_formKey.currentState!.validate() && date != null){
                            FirebaseFirestore.instance
                                .collection('activities')
                                .doc(widget.cinemaId)
                                .collection('schedule')
                                .doc().set({
                              'name' : name,
                              'time' : date,
                            });
                            showToast(
                                message: 'Added Successfully',
                                color: Colors.green,
                            );
                            Navigator.pop(context);
                          }
                        }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future pickDateTime(BuildContext context) async{
    final chosenDate = await pickDate(context);
    if(chosenDate == null) return;
    final chosenTime = await pickTime(context);
    if(chosenTime == null) return;
    setState(() {
      date = DateTime(
        chosenDate.year,
        chosenDate.month,
        chosenDate.day,
        chosenTime.hour,
        chosenTime.minute,
      );
    });
  }
}