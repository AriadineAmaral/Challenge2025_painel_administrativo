import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double borderRadius;
  final TextStyle textStyle;
  final double? width;
  final double? height;
    final double? elevation;


  const Button({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    required this.textStyle,
    this.borderRadius = 5.0,
    this.width,
    this.height,
     this.elevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: elevation, // 
        ),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
