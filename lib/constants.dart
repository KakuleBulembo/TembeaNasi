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


const kActivityForm = InputDecoration(
  border:  UnderlineInputBorder(),
  labelText: 'Enter a value',

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
