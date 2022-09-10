import 'package:flutter/material.dart';
import 'package:new_ank_customer/common/text_styles.dart';

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text(
        'Error Occured',
        style: TextStyle(letterSpacing: 0.1, fontWeight: FontWeight.w500),
      ),
      content: Text(
        message,
        style: CommonTextSyles.loginTextStyle(),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: const Text('OK!'),
        )
      ],
    ),
  );
}
