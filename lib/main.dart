import 'package:flutter/material.dart';

//Importaciones para
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


//Paginas de la aplicación
import 'firebase_options.dart';
import 'package:segurapp/Screens/login.dart';
import 'package:segurapp/Screens/registro.dart';


void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
