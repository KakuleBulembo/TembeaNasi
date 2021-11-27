import 'package:flutter/material.dart';
import '../../../constants.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({
    Key? key,
    required this.state,
    required this.time,
    required this.onTap,
  }) : super(key: key);
  final String state;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          state,
          style: Theme.of(context).textTheme.headline6,
        ),
        Container(
          height: 40,
          width: 100,
          decoration:const BoxDecoration(
            color: kBackgroundColor,
          ),
          child: Center(
            child: Text(time),
          ),
        ),
        GestureDetector(
          child: const Icon(
            IconData(57402, fontFamily: 'MaterialIcons'),
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}

