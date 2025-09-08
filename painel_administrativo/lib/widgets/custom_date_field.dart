import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';

class CustomDateField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final void Function(DateTime) onDateSelected;

  const CustomDateField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppStyles.yellow,     
                  onPrimary: Colors.black,        
                  onSurface: AppStyles.textGrey,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppStyles.blue, 
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppStyles.white,
          border: Border.all(color: AppStyles.grey2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          selectedDate != null
              ? "${selectedDate!.day.toString().padLeft(2, '0')}/"
                "${selectedDate!.month.toString().padLeft(2, '0')}/"
                "${selectedDate!.year}"
              : label,
          style: TextStyle(
            color: AppStyles.textGrey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
