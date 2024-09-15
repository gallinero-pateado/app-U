import 'package:flutter/material.dart';

//Importaciones para Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:segurapp/incidents/providers/incident_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


//Paginas de la aplicación
import 'firebase_options.dart';
import 'incidents/create_page.dart';
import 'incidents/experimental.dart';
import 'incidents/home_page.dart';
import 'incidents/update_page.dart';
import 'package:segurapp/Screens/gestion_perfil.dart';
import 'package:segurapp/Screens/login.dart';
import 'package:segurapp/Screens/mainScreen.dart';
import 'package:segurapp/Screens/registro.dart';
import 'package:segurapp/Screens/ListPage.dart';
//import 'package:flutter_map/flutter_map.dart';

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

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => IncidentProvider()),
    ],
    
    child : MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/registro': (context) => const RegistroPage(),
        '/mainScreen': (context) => const MainPage(),
        '/editarperfil': (context) => EditProfileScreen(userProfile: UserProfile(email: '', name: '', lastName: '', mobileNumber: '', language: '', country: '', city: '', address: '')),
        '/DescriptionPage':(context) => const Home(),
        '/ListPage':(context) => const Feed(),
        '/create': (context) => const CreatePage(),
        '/update': (context) => const UpdatePage(),
        '/experimental': (context) => const ExperimentalPage(),
      },
    ),);
  }
}
