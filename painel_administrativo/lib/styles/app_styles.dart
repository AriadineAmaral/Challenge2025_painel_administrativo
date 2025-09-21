import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static const Color blue = Color(0xFF00358E);
  static const Color yellow = Color(0xFFFFF200);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFFECECEC);
  static const Color grey2 = Color(0xFFD9D9D9);
  static const Color textGrey = Color(0xFF665B5B);
  static const Color green = Color(0xFF00923E);
  static const Color red = Color.fromARGB(255, 146, 0, 0);
  static const Color textPurple = Color.fromARGB(255, 75, 69, 126);

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

 static TextStyle akatab(double size, Color color, FontWeight fontWeight) {
    return GoogleFonts.akatab(
      fontSize: size,
      fontWeight: fontWeight, 
      color: color,
    );
  }

 static TextStyle kronaOne(double size, Color color, FontWeight fontWeight) {
    return GoogleFonts.kronaOne(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }

   static InputDecoration customInputDecoration({required String labelText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: blue, width: 2),
      ),
    );
  }

 static TextStyle kufam(double size, Color color, FontWeight fontWeight) {
    return GoogleFonts.kufam(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
