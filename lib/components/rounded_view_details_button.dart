import 'package:flutter/material.dart';

import '../constants.dart';


class RoundedViewDetailsButton extends StatelessWidget {
  const RoundedViewDetailsButton({
    Key? key,
    required this.title,
    required this.onPressed
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        primary: kBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16.0 * 1.5, vertical: 16.0),
      ),
      child:Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}