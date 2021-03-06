import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../constants.dart';



class ShowDialog extends StatelessWidget {
  const ShowDialog({
    Key? key,
    required this.deleteFunction,
    required this.dialogTitle,
    required this.dialogContent,
  }) : super(key: key);

  final String dialogContent;
  final String dialogTitle;
  final VoidCallback deleteFunction;

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 16.0 * 1.5, vertical: 16.0),
        ),
        onPressed: (){
          Navigator.pop(context);
        },
        child:const Center(
          child: Text(
            'Cancel'
          ),
        )
    );
    Widget deleteButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 16.0 * 1.5, vertical: 16.0),
      ),
      onPressed: deleteFunction,
      child: const Center(
        child:  Text(
          'Delete',
        ),
      ),
    );
    Widget cancelCupButton = CupertinoDialogAction(
        child:const  Center(
            child: Text(
                'Cancel',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 37,
              ),
            ),
        ),
      onPressed: (){
          Navigator.pop(context);
      },
    );
    Widget deleteCupButton = CupertinoDialogAction(
        child: const Center(
          child: Text(
              'Delete',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 37,
            ),
          ),
        ),
      onPressed: deleteFunction,
    );
    if(defaultTargetPlatform == TargetPlatform.iOS){
      return CupertinoAlertDialog(
        title: Text(
          dialogTitle,
          style:const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize:20
          ),
        ),
        content: Text(
          dialogContent,
          style:const TextStyle(
              color: Colors.white
          ),
        ),
        actions: [
          cancelCupButton,
          deleteCupButton,
        ],
      );
    }
   else if((defaultTargetPlatform == TargetPlatform.android)){
     return AlertDialog(
       backgroundColor: kBackgroundColor,
       title: Text(dialogTitle, style:const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
       content: Text(dialogContent, style:const TextStyle(color: Colors.white),),
       actions: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             const SizedBox(
               width: 50,
             ),
             cancelButton,
             deleteButton
           ],
         )
       ],
     );
   }
   else{
      return AlertDialog(
        shape: const  RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        backgroundColor: kBackgroundColor,
        title: Text(dialogTitle, style:const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        content: Text(dialogContent, style:const TextStyle(color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 50,
                ),
                cancelButton,
                deleteButton
              ],
            ),
          )
        ],
      );
    }
  }
}
