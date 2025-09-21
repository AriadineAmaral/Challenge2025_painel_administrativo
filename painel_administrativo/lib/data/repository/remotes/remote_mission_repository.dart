import 'package:painel_administrativo/data/repository/mission_repository.dart';
import 'package:painel_administrativo/models/mission.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteMissionRepository implements MissionRepository {
  final SupabaseClient client;

  RemoteMissionRepository({required this.client});

  @override
  Future<List<Mission>> listMissoes() async {
    try {
      final result = await client.from('view_missoes_completas').select('*');
      final missoes = (result as List<dynamic>)
          .map((json) => Mission.fromJson(json as Map<String, dynamic>))
          .toList();
      return missoes;
    } catch (e) {
      throw Exception('Erro ao buscar missões: $e');
    }
  }

  @override
  Future<void> updateMissao(
    int idMissao,
    String titulo,
    String? link,
    int pontos,
    DateTime dtVencimento,
  ) async {
    try {
      await client
          .from('missoes')
          .update({
            'titulo': titulo,
            'link': (link?.isEmpty ?? true) ? null : link,
            'pontos': pontos,
            'data_vencimento': dtVencimento.toIso8601String().split('T')[0],
          })
          .eq('id_missao', idMissao);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> insertMissao(
    String titulo,
    String? link,
    int pontos,
    DateTime dtVencimento,
  ) async {
    try {
      await client.from('missoes').insert({
        'titulo': titulo,
        'link': (link?.isEmpty ?? true) ? null : link,
        'pontos': pontos,
        'data_vencimento': dtVencimento.toIso8601String().split('T')[0],
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
