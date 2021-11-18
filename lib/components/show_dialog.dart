import 'package:flutter/material.dart';

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
    return AlertDialog(
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
}
