// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:Ulink/services/auth_services.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _confirmarContrasenaController = TextEditingController();

  @override
  void dispose() {
    _usuarioController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _contrasenaController.dispose();
    _confirmarContrasenaController.dispose();
    super.dispose();
  }

  Widget formItemsDesign(IconData icon, Widget item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(
        child: ListTile(
          leading: Icon(icon),
          title: item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro',
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
                key: _formKey,
                child: Column(
                  children: [
                    formItemsDesign(
                      Icons.person,
                      TextFormField(
                        controller: _usuarioController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre de usuario',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu nombre de usuario';
                          }
                          return null;
                        },
                      ),
                    ),
                    formItemsDesign(
                      Icons.email,
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu correo electrónico';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Por favor ingresa un correo electrónico válido';
                          }
                          return null;
                        },
                      ),
                    ),
                    formItemsDesign(
                      Icons.lock,
                      TextFormField(
                        controller: _contrasenaController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                    ),
                    formItemsDesign(
                      Icons.lock,
                      TextFormField(
                        controller: _confirmarContrasenaController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirmar contraseña',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor confirma tu contraseña';
                          }
                          if (value != _contrasenaController.text) {
                            return 'Las contraseñas no coinciden';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await _signUp(context);
                          if (success) {
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Usuario registrado con éxito')),
                              );
                            }
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Error al registrar usuario')),
                              );
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text('Registrar'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: RichText(
                text: const TextSpan(
                  text: '¿Ya eres miembro? ',
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Iniciar Sesión',
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

  Future<bool> _signUp(BuildContext context) async {
    String email = _emailController.text;
    String password = _contrasenaController.text;

    try {
      final result =
          await _authService.signUpWithEmailAndPassword(email, password);

      if (result != null) {
        print('Usuario registrado con éxito');
        return true;
      } else {
        print('Error al registrar usuario');
        return false;
      }
    } catch (e) {
      print('Error de registro: $e');
      return false;
    }
  }
}
