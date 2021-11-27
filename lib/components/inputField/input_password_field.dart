import 'package:flutter/material.dart';
import 'package:tembea/components/text_field_container.dart';

class InputPasswordField extends StatefulWidget {
  const InputPasswordField({
    Key? key,
    required this.hintText,
    required this.onTap,
    this.obscureText = true,
    required this.onChanged,
  }) : super(key: key);
  final String hintText;
  final VoidCallback onTap;
  final bool obscureText;
  final ValueChanged<String> onChanged;

  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormFieldContainer(
      child: TextFormField(
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: const Icon(Icons.lock, color: Colors.green),
          suffixIcon: InkWell(
            child:const Icon(Icons.visibility, color: Colors.green),
            onTap: widget.onTap,
          ),
          border: InputBorder.none,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}


