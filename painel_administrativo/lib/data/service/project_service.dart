import 'package:painel_administrativo/models/project_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectService {
  final supabase = Supabase.instance.client;

  Future<List<ProjectView>> fetchProjects() async {
    final response = await supabase
        .from('vw_analise_projetos') 
        .select('*')
        .order('data_inicio', ascending: false);

    print(response); 

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

   Future<List<ProjectView>> fetchAnaliseProjects() async {
    final response = await supabase
        .from('vw_analise_projetos_analise') 
        .select('*')
        .order('data_inicio', ascending: false);

    print(response); 

    final projects = (response as List<dynamic>)
        .map((json) => ProjectView.fromJson(json as Map<String, dynamic>))
        .toList();

    return projects;
  }

  Future<List<ProjectView>> fetchDesenvolvimentoProjects() async {
    final response = await supabase
        .from('vw_analise_projetos_desenvolvimento') 
        .select('*')
        .order('data_inicio', ascending: false);

    print(response); 

    final projects = (response as List<dynamic>)
        .map((json) => ProjectView.fromJson(json as Map<String, dynamic>))
        .toList();

    return projects;
  }

  Future<List<ProjectView>> fetchFinalizadoProjects() async {
    final response = await supabase
        .from('vw_analise_projetos_finalizado')  
        .select('*')
        .order('data_inicio', ascending: false);

    print(response); 

    final projects = (response as List<dynamic>)
        .map((json) => ProjectView.fromJson(json as Map<String, dynamic>))
        .toList();

    return projects;
  }


}