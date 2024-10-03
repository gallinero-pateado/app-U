// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:Ulink/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> keyForm = GlobalKey();
  final AuthService _authService = AuthService();
  final _emailController = TextEditingController();
  final _contrasenaController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false; // Inicializar la variable
  }

  @override
  void dispose() {
    _emailController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ulink',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Form(
                key: keyForm,
                child: formUI(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (keyForm.currentState!.validate()) {
                  bool success = await _signIn();
                  if (success) {
                    Navigator.pushNamed(context, '/mainScreen');
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al autenticar usuario')),
                      );
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor ingrese los datos correctos')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Bordes redondeados
                ),
              ),
              child: const Text("Iniciar sesión"),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/registro');
              },
              child: RichText(
                text: const TextSpan(
                  text: '¿Aún no tienes cuenta? ',
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Regístrate',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formItemsDesign(IconData icon, Widget item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        formItemsDesign(
          Icons.email,
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
            ),
            keyboardType: TextInputType.emailAddress,
            maxLength: 32,
            autofocus: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese su correo electrónico';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Por favor ingrese un correo electrónico válido';
              }
              return null;
            },
          ),
        ),
        formItemsDesign(
          Icons.remove_red_eye,
          TextFormField(
            controller: _contrasenaController,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese su contraseña';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Future<bool> _signIn() async {
    String email = _emailController.text;
    String password = _contrasenaController.text;

    try {
      final user =
          await _authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        print('Usuario autenticado correctamente');
        return true;
      } else {
        print('Error al autenticar usuario');
        return false;
      }
    } catch (e) {
      print('Error de autenticación: $e');
      return false;
    }
  }
}
