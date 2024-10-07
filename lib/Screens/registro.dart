import 'package:flutter/material.dart';
import 'package:Ulink/services/auth_services.dart'; // Servicio de autenticación

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro',
          style: TextStyle(
            color: Colors.blue, // Color del título
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Centra el título
        backgroundColor: Colors.white, // Fondo blanco en la barra de navegación
        elevation: 0, // Sin sombra
        iconTheme: const IconThemeData(
            color: Colors.blue), // Ícono de la flecha de regreso en azul
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField('Nombres', (value) {
                _firstName = value;
              }),
              _buildTextField('Apellidos', (value) {
                _lastName = value;
              }),
              _buildTextField('Email', (value) {
                _email = value;
              }),
              _buildTextField('Contraseña', (value) {
                _password = value;
              }, obscureText: true),
              _buildTextField('Confirmar Contraseña', (value) {
                _confirmPassword = value;
              }, obscureText: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _registerUser();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, // Botón de registro azul
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Bordes redondeados
                  ),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
                  child: Text(
                    'Registrarse',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // No hacer nada de momento
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      251, 3, 228, 244), // Botón de registro azul
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Bordes redondeados
                  ),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  child: Text(
                    'Registrarse como empresa',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      text: '¿Ya tienes cuenta? ',
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Inicia sesión',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para generar los campos de texto
  Widget _buildTextField(String labelText, Function(String) onSaved,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
              color: Colors.lightBlue), // Texto del label en azul claro
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Colors.lightBlue), // Borde azul claro
            borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Colors.blue), // Borde azul al enfocarse
            borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
          ),
        ),
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese su $labelText';
          }
          return null;
        },
        onSaved: (value) {
          onSaved(value ?? '');
        },
      ),
    );
  }

  // Método para registrar al usuario
  void _registerUser() async {
    if (_password != _confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    // Lógica de autenticación usando AuthService
    final response = await _authService.signUpWithDetails(
      _firstName,
      _lastName,
      _email,
      _password,
    );

    if (response != null) {
      if (response.containsKey('error')) {
        // Mostrar mensaje de error proveniente del servidor
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response['error']}')),
        );
      } else {
        // Registro exitoso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario registrado exitosamente')),
        );
        Navigator.pushNamed(
            context, '/login'); // Redirigir a la pantalla de inicio de sesión
      }
    } else {
      // Error general si no se recibió respuesta del servidor
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al registrar usuario')),
      );
    }
  }
}
