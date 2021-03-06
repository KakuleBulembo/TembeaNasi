import 'package:flutter/material.dart';

import '../text_field_container.dart';


class RoundedInputField extends StatelessWidget {
  const RoundedInputField({
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.validator,
    Key? key,
  }) : super(key: key);
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final dynamic validator;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldContainer(
      child: TextFormField(
        validator: validator,
        cursorColor: Colors.green,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          icon: Icon(
            icon,
            color: Colors.green,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}