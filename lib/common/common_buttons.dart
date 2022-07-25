import 'package:flutter/material.dart';
import 'package:new_ank_customer/common/text_styles.dart';

import 'common_styles.dart';

Widget materialButtonCommon(
    {required VoidCallback fun, required String text, double? elevation}) {
  return MaterialButton(
    elevation: elevation,
    height: 30,
    minWidth: 60,
    child: Container(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(
          text,
          style: CommonTextSyles.textDataWhite14(),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 8, offset: Offset(1, -2))
          ]),
    ),
    onPressed: fun,
  );
}

class RoundedButton extends StatelessWidget {
  final String title;
  final Function() onpressed;

  const RoundedButton({required this.title, required this.onpressed, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: MaterialButton(
        elevation: 3,
        minWidth: MediaQuery.of(context).size.width * 0.35,
        height: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onpressed,
        child: Text(
          title,
          style: CommonStyles.sendOTPButtonTextStyle(),
        ),
        color: Colors.blueAccent[700],
        splashColor: Colors.green,
      ),
    );
  }
}
