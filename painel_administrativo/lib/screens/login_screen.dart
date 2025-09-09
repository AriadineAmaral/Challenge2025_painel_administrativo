import 'package:flutter/material.dart';
import 'package:painel_administrativo/screens/home_screen.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/generic/button.dart';
import 'package:painel_administrativo/widgets/generic/custom_text_field%20.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "EuroPro",
              style: AppStyles.kronaOne(60, AppStyles.blue, AppStyles.regular),
            ),
            Text(
              "Painel Administrativo",
              style: AppStyles.kronaOne(35, AppStyles.blue, AppStyles.regular),
            ),
            SizedBox(height: 30),
            Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                color: AppStyles.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Usuário",
                        style: AppStyles.akatab(
                          22,
                          AppStyles.textGrey,
                          AppStyles.medium,
                        ),
                      ),
                    ),
                    CustomTextField(
                      label: "Digite o usuário",
                      controller: senhaController,
                      obscureText: false,
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Senha",
                        style: AppStyles.akatab(
                          22,
                          AppStyles.textGrey,
                          AppStyles.medium,
                        ),
                      ),
                    ),
                    CustomTextField(
                      label: "Digite a senha",
                      controller: usuarioController,
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    Button(
                      text: "Entrar",

                      backgroundColor: AppStyles.blue,
                      textStyle: AppStyles.akatab(
                        24,
                        AppStyles.white,
                        AppStyles.semiBold,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
