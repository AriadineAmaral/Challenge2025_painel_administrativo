import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/button.dart';

class StatusCheckboxList extends StatelessWidget {
  final List<bool> checks;
  final List<String> statusMissao;
  final void Function(int index, bool value) onChanged;

  const StatusCheckboxList({
    super.key,
    required this.checks,
    required this.statusMissao,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            "Lista de missões",
            style: AppStyles.kufam(25, AppStyles.black, AppStyles.semiBold),
          ),
        ),

        ...List.generate(statusMissao.length, (index) {
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
                statusMissao[index],
                style: AppStyles.kufam(16, AppStyles.black, AppStyles.regular),
              ),
              const SizedBox(width: 16),
            ],
          );
        }),

        Button(
          text: "Pesquisar",
          backgroundColor: AppStyles.yellow,
          textStyle: AppStyles.akatab(
            18,
            AppStyles.black,
            AppStyles.semiBold,
          ).copyWith(height: 0.5),
          width: 100,
          height: 30,
          onPressed: () {},
        ),
      ],
    );
  }
}
