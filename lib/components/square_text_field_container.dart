import 'package:flutter/material.dart';


class SquareTextFieldContainer extends StatelessWidget {
  const SquareTextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      margin:const EdgeInsets.symmetric(vertical: 10),
      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration:const BoxDecoration(
          color: Colors.transparent,
      ),
      child: child,
    );
  }
}