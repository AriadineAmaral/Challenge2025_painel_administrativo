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

  Future<List<Map<String, dynamic>>> fetchProjetosPorMes({
    required String colaboradorNome,
  }) async {
    try {
      final response = await supabase
          .from('vw_quantidade_projetos_colaborador')
          .select('mes, mes_num, total_projetos')
          .eq('nome', colaboradorNome)
          .order('mes_num', ascending: true);

      print('Resposta projetos: $response');

      if (response == null) return [];
      return (response as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    } catch (e) {
      print('Erro ao buscar projetos do colaborador: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchEngajamentoGeral() async {
    try {
      final response = await supabase
          .from('vw_engajamento_geral')
          .select('engajamento, percentual_total, mes');

      print('Resposta engajamento geral: $response');

      if (response == null) return [];
      return (response as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    } catch (e) {
      print('Erro ao buscar engajamento geral: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchMissoesMes({required String colaboradorNome}) async {
    try {
      final response = await supabase
          .from('vw_missoes_mes')
          .select('mes, pontos')
          .eq('nome', colaboradorNome)
          .order('mes', ascending: true);
      if (response == null) return [];
      return (response as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    } catch (e) {
      print('Erro ao buscar missões mês: $e');
      return [];
    }
  }
}