import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';


class StatusCheckboxList extends StatelessWidget {
  final List<bool> checks;
  final List<String> status;
  final void Function(int index, bool value) onChanged;
  final String titulo;

  const StatusCheckboxList({
    super.key,
    required this.checks,
    required this.status,
    required this.onChanged,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(titulo,
            style: AppStyles.kufam(25, AppStyles.black, AppStyles.semiBold),
          ),
        ),

        ...List.generate(status.length, (index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Baseline(
                baseline: 35,
                baselineType: TextBaseline.alphabetic,
                child: Checkbox(
                  activeColor: AppStyles.yellow,
                  checkColor: AppStyles.black,
                  value: checks[index],
                  onChanged: (bool? value) {
                    onChanged(index, value!);
                  },
                ),
              ),
              Text(
                status[index],
                style: AppStyles.kufam(16, AppStyles.black, AppStyles.regular),
              ),
              const SizedBox(width: 16),
            ],
          );
        }),
      ],
    );
  }
}
