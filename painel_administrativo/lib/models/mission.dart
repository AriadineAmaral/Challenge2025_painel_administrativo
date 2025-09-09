class Mission {
  final int idMissao;
  final String titulo;
  final int pontos;
  final bool? disponivel;
  final DateTime dataInicio;
  final DateTime dataVencimento;
  final String? link;
  final String? status;

  Mission({
    required this.idMissao,
    required this.titulo,
    required this.pontos,
     this.disponivel,
    required this.dataInicio,
    required this.dataVencimento,
    this.link,
    this.status,
  });

  factory Mission.fromMap(Map<String, dynamic> map) {
    final vencimento = DateTime.parse(map['data_vencimento'] as String);
    return Mission(
      idMissao: map['id_missao'],
      titulo: map['titulo'],
      pontos: map['pontos'],
      disponivel: map['disponivel'],
      dataInicio: calcularDataInicio(vencimento),
      dataVencimento: vencimento,
      link: map['link'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_missao': idMissao,
      'titulo': titulo,
      'pontos': pontos,
      'disponivel': disponivel,
      'data_vencimento': dataVencimento,
    };
  }

  static DateTime calcularDataInicio(DateTime dataVencimento) {
    return DateTime(dataVencimento.year, dataVencimento.month, 1);
  }
}
