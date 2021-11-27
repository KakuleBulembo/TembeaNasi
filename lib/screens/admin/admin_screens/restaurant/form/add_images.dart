import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tembea/components/show_toast.dart';
import 'package:tembea/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:path/path.dart';
import 'package:tembea/components/firebase_api.dart';


class AddImages extends StatefulWidget {
  const AddImages({Key? key}) : super(key: key);

  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  bool showSpinner = false;
  List<File> files =[];
  TaskSnapshot? snap;
  bool upload = false;
  List<String> imgRef =[];

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
        appBar: AppBar(
          title: const Text('Add Images'),
          backgroundColor: kBackgroundColor.withOpacity(0.3),
          actions: [
            Center(
              child: InkWell(
                onTap: (){
                  setState(() {
                    showSpinner = true;
                  });
                  uploadFile().whenComplete(() {
                    Navigator.pop(context, imgRef);
                    setState(() {
                      showSpinner =false;
                    });
                  });

                },
                child:const Text(
                    'Upload ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
              ),
            )
          ],
        ),
        body: GridView.builder(
            itemCount: files.length + 1,
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index){
              return index == files.length
                  ? Center(
                child: IconButton(
                  icon:const Icon(Icons.add),
                  onPressed: (){
                    if(files.length < 3){
                      upload == false ? selectFile() : null;
                    }
                  },
                ),
              )
                  : Container(
                margin:const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(files[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
        )
      ),
    );
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
      files.add(File(path));
    });
  }

  Future uploadFile() async{
    for(var file in files){
      final dateTime = DateTime.now().millisecondsSinceEpoch;
      final fileName = basename(file.path);
      final destination = 'restaurants/$dateTime$fileName';
        snap = await FirebaseApi.uploadFile(destination, file);
        if( snap!.state == TaskState.success){
          final String downloadUrl = await snap!.ref.getDownloadURL();
            setState(() {
              imgRef.add(downloadUrl);
            });
        }
        else{
          setState(() {
            showSpinner = true;
          });
        }
    }
    setState(() {
      showSpinner = false;
    });
    return showToast(
      message: "Images Updated Successfully",
      color: Colors.green,
    );
  }
}
