import 'package:flutter/material.dart';

//Importaciones para Supabase
import 'package:supabase_flutter/supabase_flutter.dart';

//Paginas de la aplicación
import 'package:Ulink/Screens/login.dart';
import 'package:Ulink/Screens/registro.dart';

void main() async {
  await Supabase.initialize(
    url: 'aws-0-sa-east-1.pooler.supabase.com',
    anonKey: 'fytxid-0xamfY-kersev',
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/registro': (context) => const RegistroPage(),
      },
    );
  }
}
