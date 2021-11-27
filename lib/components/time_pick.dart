import 'package:flutter/material.dart';
import 'package:tembea/components/square_button.dart';

class TimePick extends StatelessWidget {
  const TimePick({
    Key? key,
    required this.label,
    required this.labelColor,
    required this.time,
    required this.onPressed,
  }) : super(key: key);
  final String label;
  final Color labelColor;
  final String time;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: DateButton(
            text: time,
            onPressed: onPressed,
          ),
        )
      ],
    );
  }
}
