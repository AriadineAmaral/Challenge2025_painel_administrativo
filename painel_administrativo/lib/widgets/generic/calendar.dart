import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';

class Calendar {
  static Future<DateTime?> selecionarData({
    required BuildContext context,
    required DateTime dataInicial,
    DateTime? primeiraData,
    DateTime? ultimaData,
  }) {
    return showDatePicker(
      context: context,
      initialDate: dataInicial,
      firstDate: primeiraData ?? DateTime(2000),
      lastDate: ultimaData ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppStyles.yellow,
              onPrimary: Colors.black,
              onSurface: AppStyles.textGrey,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppStyles.blue),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
