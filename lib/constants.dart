import 'package:flutter/material.dart';



const kPrimaryColor = Color(0xFF2697FF);
const kSecondaryColor = Color(0xFF2A2D3E);
const kBackgroundColor = Color(0xFF212332);

const kInputDecoration = InputDecoration(
  hintText: 'Enter value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightGreen,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
);

const kTextColor = TextStyle(color: Colors.white);
const kTextColor2 = TextStyle(color: Colors.white70);
const kRoundedInputDecoration = InputDecoration(
  hintText: 'Enter value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightGreen,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
);


const kActivityForm = InputDecoration(
  border:  UnderlineInputBorder(),
  labelText: 'Write Something',

  enabledBorder:  UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blue,
    ),
  ),
);

const kTopRounded = RoundedRectangleBorder(
  side: BorderSide(color: kSecondaryColor, width: 1),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  ),
);

const kBottomRounded = RoundedRectangleBorder(
  side: BorderSide(color: kSecondaryColor, width: 1),
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(30),
    bottomRight: Radius.circular(30),
  ),
);
const kRoundedBorder = RoundedRectangleBorder(
  side: BorderSide(color: kSecondaryColor, width: 1),
  borderRadius: BorderRadius.all(
    Radius.circular(0),
  ),
);
