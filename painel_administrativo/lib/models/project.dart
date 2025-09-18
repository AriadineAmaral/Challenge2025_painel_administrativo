class ProjectView {
  final int idProjeto;
  final String titulo;
  final String descricao;
  final String nomeProjetoTipo;
  final String nomeArquivo;
  final String status;
  final DateTime dataInicio;
  final String nomeColaborador;
  final String? fotoUrl;
  final int idStatusProjeto;
  final String? caminhoArquivo;

  ProjectView({
    required this.idProjeto,
    required this.titulo,
    required this.descricao,
    required this.nomeProjetoTipo,
    required this.nomeArquivo,
    this.caminhoArquivo, 
    required this.status,
    required this.dataInicio,
    required this.nomeColaborador,
    this.fotoUrl,
    required this.idStatusProjeto,
  });

  factory ProjectView.fromJson(Map<String, dynamic> json) {
    return ProjectView(
      idProjeto: json['id_projeto'] as int,
      titulo: json['titulo'] as String,  
      descricao: json['descricao'] as String? ?? '',
      nomeProjetoTipo: json['nome_projeto'] as String? ?? '',
      nomeArquivo: json['nome_arquivo'] as String? ?? '',
      caminhoArquivo: json['caminho'] as String? ?? '',
      status: json['status'] as String? ?? '',
      dataInicio: DateTime.parse(json['data_inicio'] as String),
      nomeColaborador: json['nome_colaborador'] as String? ?? '',
      fotoUrl: json['foto_url'] as String?,
      idStatusProjeto: json['id_status_projetos'] as int,
    );
  }

  
}