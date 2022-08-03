import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonStyles {
  CommonStyles._();

  static textFieldStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      letterSpacing: 0.3,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ));
  }

  static whiteText15BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static enterYourNumberTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[600],
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w300,
    ));
  }

  static otpVerificationMessage() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[800],
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w500,
    ));
  }

  static whiteText12BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static whiteText13BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static whiteText10BoldW400() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static whiteText8BoldW400() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static whiteText16BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static blackText17BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      letterSpacing: 0.1,
      color: Colors.black,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ));
  }

  static blueText12BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.19,
            color: Colors.blue,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static blueText11BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.19,
            color: Colors.blue,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat'));
  }

  static black57S18() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black54));
  }

  static black57S17() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black87));
  }

  static blackS18() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black));
  }

  static black57S14({Color? color}) {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: color ?? Colors.black45));
  }

  static blackS16Thin() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black));
  }

  static black12() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black));
  }

  static black11() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 11, color: Colors.black));
  }

  static black12reg() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black));
  }

  static black1154() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 11, color: Colors.black54));
  }

  static green12() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 12, color: Colors.green));
  }

  static green15() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15, color: Colors.green));
  }

  static black13() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black));
  }

  static black14() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(fontSize: 14, color: Colors.black));
  }

  static black15() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black));
  }

  static black16() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      letterSpacing: 1.2,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ));
  }

  static black11LineThrough() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11,
            color: Colors.black,
            decoration: TextDecoration.lineThrough));
  }

  static red12() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13, color: Colors.red));
  }

  static red15() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red));
  }

  static red9() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 10, color: Colors.red));
  }

  static green9() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 9, color: Colors.green));
  }

  static black13thin() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black));
  }

  static black13thinW54() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black54));
  }

  static black1254thin() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black54));
  }

  static black1254W700() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 12, color: Colors.black54));
  }

  static black1654thin() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black54));
  }

  static black1654W400() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black54));
  }

  static black1054W400() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black54));
  }

  static black10thin() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 10, color: Colors.black54));
  }

  static black25thin() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 25, color: Colors.black87));
  }

  static blue12thin() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 13, color: Colors.blue));
  }

  static blue12() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 12, color: Colors.blue));
  }

  static blue12Underline() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.blue,
            decoration: TextDecoration.underline));
  }

  static underlineS12Color({required Color color}) {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: color,
            decoration: TextDecoration.underline));
  }

  static blue14900() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.blue[900]));
  }

  static pink15W800() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: Colors.pink[900]));
  }

  static blue20900() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.blue[900]));
  }

  static blue13() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 14, color: Colors.blue));
  }

  static blue13900() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 14, color: Colors.blue));
  }

  static blue18900() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: Colors.blue[900],
            inherit: false));
  }

  static blackw54s9Thin() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 9,
      color: Colors.black54,
    ));
  }

  static blackw12s12() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: Colors.black45,
    ));
  }

  static white12() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: Colors.white,
    ));
  }

  static white11() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 11,
      color: Colors.white,
    ));
  }

  static white9() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 9,
      color: Colors.white,
    ));
  }

  static blackw54s20Thin() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color.fromARGB(255, 36, 22, 22),
    ));
  }

  static blackw54s9ThinUnderline() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 9,
            color: Colors.black54,
            decoration: TextDecoration.underline));
  }

  static loginTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.5,
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat'));
  }

  static loginTextStyleBlack() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.5,
            color: Colors.black54,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat'));
  }

  static submitTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[900],
      letterSpacing: 0.2,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ));
  }

  static bold18TextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown,
      letterSpacing: 0.2,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ));
  }

  static genderTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[900],
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ));
  }

  static sendOTPButtonTextStyle() {
    return GoogleFonts.roboto(
        textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 0.15,
      // backgroundColor: Colors.transparent,
      fontSize: 16,
      fontWeight: FontWeight.w900,
    ));
  }

  static errorTextStyleStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.redAccent,
      fontSize: 13,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ));
  }

  static normalText() {
    return GoogleFonts.roboto(
        textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ));
  }

  static labelTextSyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[600],
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w300,
    ));
  }

  static labelTextSyleWhite() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w300,
    ));
  }
}
