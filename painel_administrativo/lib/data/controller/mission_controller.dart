import 'package:flutter/material.dart';

class MissionController {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController pontosController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController dataVencimentoController =
      TextEditingController();

  void dispose() {
    tituloController.dispose();
    pontosController.dispose();
    linkController.dispose();
    dataVencimentoController.dispose();
  }
}
