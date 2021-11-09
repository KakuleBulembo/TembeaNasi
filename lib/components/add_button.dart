import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
    required this.title,
    required this.addLabel,
    required this.onPressed
  }) : super(key: key);
  final String title;
  final String addLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Events',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
        ),
        ElevatedButton.icon(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0 * 1.5,
              vertical: 16.0,
            ),
          ),
          onPressed: onPressed,
          icon:const Icon(Icons.add),
          label:  Text(addLabel, style: const TextStyle(color: Colors.white),),

        ),
      ],
    );
  }
}
