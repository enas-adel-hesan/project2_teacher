import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
Future<void> showSuccessFlushBar(BuildContext context) {
  return Flushbar(
    margin: EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(12),
    backgroundColor: Colors.green.shade600,
    icon: Icon(
      Icons.check_circle,
      size: 28,
      color: Colors.white,
    ),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: Colors.greenAccent,
    messageText: Text(
      "Course added successfully",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  ).show(context);
}
