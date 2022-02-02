import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tembea/constants.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    Key? key,
    required this.isChecked,
    required this.onChanged,
    required this.content,
  }) : super(key: key);
  final bool isChecked;
  final ValueChanged onChanged;
  final String content;


  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isSelected = false;
  @override
  void initState() {
    isSelected = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isSelected = !isSelected;
          widget.onChanged(isSelected);
        });
      },
      child: AnimatedContainer(
        height: MediaQuery.of(context).size.width * 0.15,
        width: MediaQuery.of(context).size.width * 0.25,
        margin:const EdgeInsets.all(15.0),
        duration:const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: isSelected ? kSecondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isSelected ? Colors.transparent : kSecondaryColor,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            widget.content,
            style: GoogleFonts.acme(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
            ),
          ),
        ),
      ),
    );
  }
}
