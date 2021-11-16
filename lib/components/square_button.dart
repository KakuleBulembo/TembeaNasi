import 'package:flutter/material.dart';
import '../constants.dart';

class DateButton extends StatelessWidget {
  const DateButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60.0),
        primary: kSecondaryColor,
      ),
      child:  FittedBox(
        child:  Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white70,
          ),
        ),
      ),
      onPressed: onPressed ,
    );
  }
}