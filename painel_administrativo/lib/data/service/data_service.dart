import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class DataService {
  Future<List<String>> fetchColaboradores() async {
  try {
    final response = await supabase
        .from('vw_colaboradores_app')
        .select('nome')
        .order('nome');

    if (response == null) return [];
    return (response as List).map((e) => e['nome'] as String).toList();
  } catch (e) {
    print('Erro ao buscar colaboradores: $e');
    return [];
  }
}

  Future<List<Map<String, dynamic>>> fetchEngajamentoPorColaborador({
    required String colaboradorNome,
  }) async {
    try {
      final response = await supabase
          .from('vw_engajamento_por_colaborador')
          .select('mes, total_pontos, porcentagem_total')
          .eq('nome', colaboradorNome);

      print('Resposta engajamento: $response');

      if (response == null) return [];
      return (response as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    } catch (e) {
      print('Erro ao buscar engajamento do colaborador: $e');
      return [];
    }
  }
}