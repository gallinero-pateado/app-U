import 'package:flutter/material.dart';

//Importaciones para Supabase
import 'package:supabase_flutter/supabase_flutter.dart';

//Pantallas de la aplicación
import 'package:Ulink/Screens/login.dart';
import 'package:Ulink/Screens/registro.dart';
import 'package:Ulink/Screens/recover_password.dart';

void main() async {
  // Inicialización de Supabase
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'aws-0-sa-east-1.pooler.supabase.com',
    anonKey: 'fytxid-0xamfY-kersev',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(), // Pantalla de login
        '/registro': (context) =>
            const RegisterScreen(), // Pantalla de registro
        '/recuperar': (context) =>
            const RecoverPasswordPage(), // Pantalla de recuperar contraseña
      },
    );
  }
}
