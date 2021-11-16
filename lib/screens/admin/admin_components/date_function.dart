import 'package:flutter/material.dart';

DateTime ? date;

Future<DateTime?> pickDate(BuildContext context) async{
  final initialDate = DateTime.now();
  final newDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(DateTime.now().year - 5),
    lastDate: DateTime(DateTime.now().year + 5),
  );
  if(newDate == null) return null;
  return newDate;
}

Future<TimeOfDay?> pickTime(BuildContext context) async{
  const initialTime = TimeOfDay(hour: 9, minute: 0);
  final newTime = await showTimePicker(
      context: context,
      initialTime: date != null ? TimeOfDay(hour: date!.hour, minute: date!.minute) : initialTime
  );
  if(newTime == null) return null;
  return newTime;
}
