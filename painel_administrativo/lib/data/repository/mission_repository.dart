import 'package:painel_administrativo/models/mission.dart';

abstract class MissionRepository {
  Future<List<Mission>> listMissoes();
  Future<void> updateMissao(
    int idMissao,
    String titulo,
    String? link,
    int pontos,
    DateTime dtVencimento,
  );
  Future<void> insertMissao(String titulo,
    String? link,
    int pontos,
    DateTime dtVencimento);
}
