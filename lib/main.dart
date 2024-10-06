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
    url: 'https://cwarjxvkdpaoolwwatve.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN3YXJqeHZrZHBhb29sd3dhdHZlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjYxNzgzMTIsImV4cCI6MjA0MTc1NDMxMn0.a9iD-vJAzl0jZO_xiei0iyIsH7yKuP2x6ZbwH3zXPG8',
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
