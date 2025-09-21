import 'package:bcrypt/bcrypt.dart';
import 'package:painel_administrativo/data/repository/administrator_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteAdministratorRepository implements AdministratorRepository {
  final SupabaseClient client;

  RemoteAdministratorRepository({required this.client});

  @override
  Future<bool> loginAdministrador(String login, String senhaDigitada) async {
    try {
      final response = await Supabase.instance.client
          .from('administradores')
          .select()
          .eq('login', login)
          .single();

      if (response.isEmpty) return false;

      final senhaSalva = response['senha'] as String;
      return BCrypt.checkpw(senhaDigitada, senhaSalva);
    } catch (e) {
      return false;
    }
  }
}
