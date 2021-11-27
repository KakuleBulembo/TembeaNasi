import 'package:flutter/material.dart';

DateTime ? date;

Future<TimeOfDay?> pickDayTime(BuildContext context) async{
  const initialTime = TimeOfDay(hour: 9, minute: 0);
  final newTime = await showTimePicker(
      context: context,
      initialTime: date != null ? TimeOfDay(hour: date!.hour, minute: date!.minute) : initialTime
  );
  if(newTime == null) return null;
  return newTime;
}