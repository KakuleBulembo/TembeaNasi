import 'package:flutter/material.dart';

class ViewTime extends StatelessWidget {
  const ViewTime({
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
    return Expanded(
        child: Column(
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
              data,
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
        )
    );
  }
}

