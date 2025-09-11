class Project {
  final int idProjeto;
  final String titulo;
  final String? descricao;
  final DateTime dataInicio;
  final DateTime? dataFim;
  final int? idStatusProjeto;
  final int? tipoProjeto;

  Project({
    required this.idProjeto,
    required this.titulo,
    this.descricao,
    required this.dataInicio,
    this.dataFim,
    this.idStatusProjeto,
    this.tipoProjeto,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      idProjeto: json['id_projeto'] as int,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String?,
      dataInicio: DateTime.parse(json['data_inicio'] as String),
      dataFim: json['data_fim'] != null
          ? DateTime.parse(json['data_fim'] as String)
          : null,
      idStatusProjeto: json['id_status_projetos'] as int?,
      tipoProjeto: json['tipo_projeto'] as int?,
    );
  }
}
