import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
        () => Navigator.popAndPushNamed(context, "MainHomePage"));
  }

  Widget build(BuildContext context) {
    return Scaffold(body: buildBody());
  }

  buildBody() {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 250,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/garudayaan.jpeg'))),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'ANK Speed',
            style: TextStyle(
              color: Colors.green.shade900,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(
            strokeWidth: 5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade900),
          )
        ],
      ),
    );
  }
}
