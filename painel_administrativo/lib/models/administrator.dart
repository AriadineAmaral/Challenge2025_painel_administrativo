class Administrator {
  final int id;
  final String login;
  final String senha;

  Administrator({
    required this.id,
    required this.login,
    required this.senha,
  });

  factory Administrator.fromMap(Map<String, dynamic> map) {
    return Administrator(
      id: map['id'],
      login: map['login'],
      senha: map['senha'],
    );
  }
}
