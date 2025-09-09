import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final IconData? icon;
  final double? width;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.icon,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(color: AppStyles.textGrey),
          prefixIcon: icon != null ? Icon(icon) : null,
          filled: true,
          fillColor: AppStyles.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppStyles.grey2, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppStyles.yellow, width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
