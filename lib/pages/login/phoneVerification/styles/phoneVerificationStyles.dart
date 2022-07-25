import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneVerificationStyles {
  PhoneVerificationStyles._();
  static loginTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            letterSpacing: 0.5,
            color: Color(0xffC0C0C0),
            backgroundColor: Colors.transparent,
            fontSize: 60,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat'));
  }

  static submitTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[900],
      backgroundColor: Colors.transparent,
      letterSpacing: 0.2,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ));
  }

  static genderTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[900],
      backgroundColor: Colors.transparent,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ));
  }

  static sendOTPButtonTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 0.2,
      // backgroundColor: Colors.transparent,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ));
  }

  static errorTextStyleStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.redAccent,
      backgroundColor: Colors.transparent,
      fontSize: 13,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ));
  }

  static enterYourNumberTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[600],
      backgroundColor: Colors.transparent,
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w300,
    ));
  }
}
