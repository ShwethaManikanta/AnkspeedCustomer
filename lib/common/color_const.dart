import 'dart:ui';

class ColorConstant {
  static Color whiteA7007f = fromHex('#7fffffff');

  static Color gray400 = fromHex('#c4c4c4');

  static Color red600 = fromHex('#e82e2e');

  static Color gray800 = fromHex('#61290f');

  static Color gray900 = fromHex('#1a1a1f');

  static Color purple800Cc = fromHex('#171717');

  static Color deepPurple700 = fromHex('#5FCAF8');

  static Color green800 = fromHex('#009c0f');

  static Color gray200 = fromHex('#ebebeb');

  static Color blue800Cc = fromHex('#5FCAF8');

  static Color gray201 = fromHex('#ede8e8');

  static Color gray50 = fromHex('#fafafa');

  static Color green400 = fromHex('#61b882');

  static Color gray100 = fromHex('#f7f7f7');

  static Color greenA700 = fromHex('#05b517');

  static Color greenA701 = fromHex('#059940');

  static Color black900 = fromHex('#000000');

  static Color indigoA700 = fromHex('#171717');

  static Color black90040 = fromHex('#40000000');

  static Color deepPurpleA200 = fromHex('#ab3dff');

  static Color whiteA700 = fromHex('#ffffff');

  static Color redA700 = fromHex('#ff0000');

  static Color gray8007f = fromHex('#7f474545');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
