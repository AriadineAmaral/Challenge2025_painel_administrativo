import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static const Color blue = Color(0xFF00358E);
  static const Color yellow = Color(0xFFFFF200);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFECECEC);
  static const Color grey2 = Color(0xFFD9D9D9);
  static const Color textGrey = Color(0xFF665B5B);

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  TextStyle akatab(double size, Color color, FontWeight fontWeight) {
    return GoogleFonts.akatab(
      fontSize: size,
      fontWeight: fontWeight, 
      color: color,
    );
  }

  TextStyle kronaOne(double size, Color color, FontWeight fontWeight) {
    return GoogleFonts.kronaOne(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }

  TextStyle kufam(double size, Color color, FontWeight fontWeight) {
    return GoogleFonts.kufam(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
