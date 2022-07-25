import 'package:flutter/material.dart';

showSnackBar(msg, color, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      elevation: 3.0,
      backgroundColor: color,
    ),
  );
}
