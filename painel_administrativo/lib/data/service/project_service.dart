import 'package:painel_administrativo/models/project.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectService {
  final supabase = Supabase.instance.client;

  Future<List<ProjectView>> fetchProjects({
    String? searchTerm,
    String? status,
  }) async {
    var query = supabase.from('vw_analise_projetos').select('*');

    if (status != null && status.isNotEmpty) {
      query = query.eq('status', status);
    }

    if (searchTerm != null && searchTerm.isNotEmpty) {
      final formattedSearchTerm = '%$searchTerm%';
      query = query.or(
        'titulo.ilike.$formattedSearchTerm,descricao.ilike.$formattedSearchTerm,nome_colaborador.ilike.$formattedSearchTerm',
      );
    }

    final response = await query.order('data_inicio', ascending: false);

    final projects = (response as List<dynamic>)
        .map((json) => ProjectView.fromJson(json as Map<String, dynamic>))
        .toList();

    return projects;
  }

  Future<void> updateProjectStatus(int projectId, int newStatusId) async {
    await supabase
        .from('projetos')
        .update({'id_status_projetos': newStatusId})
        .eq('id_projeto', projectId);
  }
}