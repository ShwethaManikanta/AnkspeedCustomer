import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  final titleLabel;
  final maxLength;
  final icon;

  final controller;
  final inputType;
  UserTextField(
      {@required this.titleLabel,
      @required this.maxLength,
      @required this.icon,
      @required this.controller,
      @required this.inputType});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: titleLabel,
          suffixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) {
          if (value!.length != maxLength) {
            if (maxLength == 6) {
              return "Minimum 6 Digits Required";
            } else {
              return "Minimum 10 Digits Required";
            }
          }
          return null;
        },
      ),
    );
  }
}
