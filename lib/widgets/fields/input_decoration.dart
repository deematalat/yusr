import 'package:flutter/material.dart';

InputDecoration inputDecoration(String labelText, IconData iconData,
    {String? prefix, String? helperText, String? hintText}) {
  return InputDecoration(
    // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    helperText: helperText,
    labelText: labelText,
    // labelStyle: TextStyle(color: Colors.grey),
    // fillColor: Colors.grey.shade200,
    // filled: true,
    prefixText: prefix,
    prefixIcon: Icon(
      iconData,
      size: 20,
    ),
    prefixIconConstraints: BoxConstraints(minWidth: 60),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Color(0xFF8F8996))),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Color(0xFF0E497A))),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.red)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Color(0xFF8F8996))),
  );
}