import 'package:flutter/material.dart';
import 'package:painel_administrativo/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  runApp(const PainelAdministrativo());

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ikxlfarvmokiwjfqqial.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlreGxmYXJ2bW9raXdqZnFxaWFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkxNzAxOTUsImV4cCI6MjA2NDc0NjE5NX0.0b4EJzlHDDTD3m9pjYAVcjLNoOqjWWQJVw2WWBUb8dg',
  );

  runApp(const PainelAdministrativo());
}

class PainelAdministrativo extends StatelessWidget {
  const PainelAdministrativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
