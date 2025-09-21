import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';

class StatusCheckboxListWithSearch extends StatelessWidget {
  final List<bool> checks;
  final List<String> status;
  final void Function(int index, bool value) onChanged;
  final String titulo;
  final TextEditingController searchController;
  final void Function(String value) onSearchChanged;

  const StatusCheckboxListWithSearch({
    super.key,
    required this.checks,
    required this.status,
    required this.onChanged,
    required this.titulo,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 780,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  titulo,
                  style: AppStyles.kufam(25, AppStyles.black, AppStyles.semiBold),
                ),
                const SizedBox(width: 16),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...List.generate(status.length, (index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            style: AppStyles.kufam(
                              16,
                              AppStyles.black,
                              AppStyles.regular,
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 35,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppStyles.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppStyles.blue,
                    width: 2,
                  ), // Defina a cor e a espessura
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              style: AppStyles.kufam(14, AppStyles.black, AppStyles.regular),
              onChanged: onSearchChanged,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
