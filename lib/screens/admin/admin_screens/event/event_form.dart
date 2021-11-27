import 'dart:io' ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tembea/components/firebase_api.dart';
import 'package:tembea/components/inputField/description_text_field.dart';
import 'package:tembea/components/inputField/square_input_text_field.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/components/square_button.dart';
import 'package:tembea/constants.dart';
import 'package:intl/intl.dart';
import 'package:tembea/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tembea/screens/admin/admin_components/date_function.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:universal_html/html.dart' as res;


class EventForm extends StatefulWidget {
  const EventForm({Key? key}) : super(key: key);
  static String id = 'event_form';

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  DateTime ? date;
  String selectedType = 'Event';
  String getText() {
    if (date == null){
      return "Select Date and Time";
    }
    else{
      return DateFormat('dd/MM/yyyy HH:mm').format(date!);
    }
  }
  UploadTask? task;
  File? file;
  res.File? webFile;
  String? name;
  String? location;
  String? description;
  String? price;
  TaskSnapshot? snap;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    String? fileName ;
    if(kIsWeb){
       setState(() {
         fileName = webFile != null ? 'Image Selected' : 'No Image Selected';
       });
    }
    else{
       setState(() {
         fileName = file != null ? basename(file!.path) : 'No Image Selected';
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
        resizeToAvoidBottomInset: true,
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          title: const Text('Add Event'),
          backgroundColor: kBackgroundColor.withOpacity(0.3),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
              child: Container(
                padding: const EdgeInsets.only(top: 0, left: 30, right: 30.0, bottom: 30),
               decoration: const BoxDecoration(
                 color: kSecondaryColor,
               ),
                 width: 400,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children:  [
                 SquareInputTextField(
                     initialValue: '',
                     labelText: 'Event\'s Name',
                     onChanged: (value){
                       name = value;
                     },
                 ),
                SquareInputTextField(
                    initialValue: '',
                    labelText: 'Event\'s Location',
                    onChanged: (value){
                      location = value;
                    },
                ),

                DescriptionTextField(
                    initialValue: '',
                    description: 'Event\'s description',
                    onChanged: (value){
                      description = value;
                  }
                ),
                SquareInputTextField(
                    initialValue: '',
                    labelText: 'Event\'s participation price',
                    onChanged: (value){
                      price = value;
                    }
                ),
                     const SizedBox(
                       height: 20.0,
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
                     DateButton(
                       text: "Select Image",
                       onPressed: () {
                         kIsWeb ? selectWebImage() : selectFile();
                       }
                     ),
                     const SizedBox(
                       height: 5.0,
                     ),
                     Center(
                       child: Text(
                         fileName!,
                           style: const TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w500,
                             color: Colors.white70
                           )
                       ),
                     ),
                     const SizedBox(
                       height: 30.0,
                     ),

                     Center(
                       child: RoundedButton(
                         buttonName: 'Add Event',
                         onPressed: () async{
                           setState(() {
                             showSpinner = true;
                           });
                           if(kIsWeb){
                             await uploadFileWeb().then((value) => showToast(
                               message: "Events Added Successfully",
                               color: Colors.green,
                             ));
                             setState(() {
                               showSpinner = false;
                             });
                             Navigator.pop(context);
                           }
                           else{
                             await uploadFile().then((value) => showToast(
                               message: "Events Added Successfully",
                               color: Colors.green,
                             )).then((value) {
                               setState(() {
                                 showSpinner = false;
                               });
                               Navigator.pop(context);
                             });
                           }
                         },
                         color: Colors.green,
                       ),
                     ),
                   ],
                 ),
                  ),
          ),
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

  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg']
    );
    if(result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async{
    if(file == null) return;
    final fileName = basename(file!.path);
    final destination = 'events/$fileName';
    snap = await FirebaseApi.uploadFile(destination, file!);
        if( snap!.state == TaskState.success){
          final String downloadUrl= await snap!.ref.getDownloadURL();
          DateTime time = DateTime.now();
          await FirebaseFirestore.instance.collection('activities').doc().set({
            'Name' : name,
            'Location': location,
            'Description' : description,
            'Price' : price,
            'Date' : date,
            'PhotoUrl': downloadUrl,
            'File' : fileName,
            'Type' : selectedType,
            'ts' : time,
          });
        }
        else{
          const CircularProgressIndicator();
        }
  }

  void selectWebImage(){
    res.FileUploadInputElement uploadInput = res.FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      setState(() {
        webFile = uploadInput.files!.first; 
      });
      final reader = res.FileReader();
      reader.readAsDataUrl(webFile!);
      reader.onLoadEnd.listen((event) {

      });
    });
  }

  Future<void> uploadFileWeb()async {
    final dateTime = DateTime.now();
    final path = 'events/$dateTime';
    snap = await FirebaseStorage.instance.refFromURL('gs://tembea-4d3c6.appspot.com')
        .child(path)
        .putBlob(webFile);
    if( snap!.state == TaskState.success) {
      final String downloadUrl = await snap!.ref.getDownloadURL();
      DateTime time = DateTime.now();
      await FirebaseFirestore.instance.collection('activities').doc().set({
        'Name': name,
        'Location': location,
        'Description': description,
        'Price': price,
        'Date': date,
        'PhotoUrl': downloadUrl,
        'Type': selectedType,
        'ts': time,
      });
    }
    else{
      const CircularProgressIndicator();
    }
  }
}
