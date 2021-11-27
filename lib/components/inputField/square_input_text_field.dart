import 'package:flutter/material.dart';

import '../../constants.dart';
import '../square_text_field_container.dart';

class SquareInputTextField extends StatelessWidget {
  const SquareInputTextField({
    Key? key,
    required this.initialValue,
    required this.labelText,
    required this.onChanged,
  }) : super(key: key);
  final String initialValue;
  final String labelText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SquareTextFieldContainer(
      child: TextFormField(
        initialValue: initialValue,
        textAlign: TextAlign.center,
        cursorColor: Colors.blue,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration:  kActivityForm.copyWith(
          labelText: labelText,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
