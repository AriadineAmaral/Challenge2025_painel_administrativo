import 'package:flutter/material.dart';
import 'package:painel_administrativo/screens/login_screen.dart';
import 'package:painel_administrativo/styles/app_styles.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final bool back = ModalRoute.of(context)?.canPop ?? false;

    return AppBar(
      backgroundColor: AppStyles.blue,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: back ? 10 : 40),
            child: Text(
              "EuroPro",
              style: AppStyles.kronaOne(30, AppStyles.white, AppStyles.regular),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false, // Remove todas as rotas anteriores
              );
            },
            child: Text(
              "Sair",
              style: AppStyles.kronaOne(16, AppStyles.white, AppStyles.regular),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
