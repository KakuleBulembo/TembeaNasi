import 'package:flutter/material.dart';

import '../../constants.dart';
import '../square_text_field_container.dart';


class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    Key? key,
    required this.initialValue,
    required this.description,
    required this.onChanged,
  }) : super(key: key);
  final String initialValue;
  final String description;
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
          labelText: description,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          isDense: true,
        ),
        maxLines: 7,
        minLines: 4,
        onChanged: onChanged,
      ),
    );
  }
}