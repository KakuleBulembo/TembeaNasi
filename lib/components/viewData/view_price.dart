import 'package:flutter/material.dart';


class ViewPrice extends StatelessWidget {
  const ViewPrice({
    Key? key,
    required this.label,
    required this.color,
    required this.data,
  }) : super(key: key);
  final String label;
  final Color color;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          '\t${data}Ksh',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}