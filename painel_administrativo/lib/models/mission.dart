class Mission {
  final int idMissao;
  final String titulo;
  final int pontos;
  final bool disponivel;
  final DateTime dataVencimento;
  final String? link;


  Mission({
    required this.idMissao,
    required this.titulo,
    required this.pontos,
    required this.disponivel,
    required this.dataVencimento,
    this.link,
  });
  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      idMissao: json['idMissao'] as int,
      titulo: json['titulo'] as String,
      pontos: json['pontos'] as int,
      disponivel: json['disponivel'] as bool,
      dataVencimento: DateTime.parse(json['dataVencimento'] as String),
      link: json['link'] as String?,

    );
  }

  static DateTime calcularDataInicio(DateTime dataVencimento) {
    return DateTime(dataVencimento.year, dataVencimento.month, 1);
  }

  String get status {
    final agora = DateTime.now();
    if (dataVencimento.year < agora.year ||
        (dataVencimento.year == agora.year && dataVencimento.month < agora.month)) {
      return 'Encerrada';
    } else if (dataVencimento.year == agora.year && dataVencimento.month == agora.month) {
      return 'Ativa';
    } else {
      return 'Programada';
    }
  }
}
