import 'package:flutter/material.dart';

//Importaciones para Supabase
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Pantallas de la aplicación
import 'package:Ulink/Screens/login.dart';
import 'package:Ulink/Screens/registro.dart';
import 'package:Ulink/Screens/recover_password.dart';

void main() async {
  // Inicialización de Supabase
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'http://127.0.0.1:8080',
    anonKey: 'e8e67a88eb2227ef34586ec2f5c362e4f4a150ad',
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
