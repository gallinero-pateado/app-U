import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://127.0.0.1:8080';
  final String _apiKey = 'e8e67a88eb2227ef34586ec2f5c362e4f4a150ad';
  // Registro de usuario con nombres, apellidos, email y contraseña
  Future<Map<String, dynamic>?> signUpWithDetails(
      String firstName, String lastName, String email, String password) async {
    final url =
        Uri.parse('$_baseUrl/register'); // Endpoint de registro de usuario
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nombres': firstName,
          'apellidos': lastName,
          'email': email,
          'password': password
        }),
      );

      // Aquí siempre retornamos la respuesta, sea éxito o error
      return jsonDecode(response.body);
    } catch (e) {
      print("Error al registrar usuario: $e");
      // Retorna un mensaje de error genérico si la excepción es lanzada
      return {'error': 'Error al registrar usuario'};
    }
  }

  // Inicio de sesión con email y contraseña
  Future<Map<String, dynamic>?> signInWithEmailAndPassword(
      String email, String password) async {
    final url = Uri.parse('$_baseUrl/login'); //endpoint de login de usuario
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(
            "Error al iniciar sesión: Código ${response.statusCode}, Respuesta: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error al iniciar sesión: $e");
      return null;
    }
  }

  // Completar el perfil del usuario
  Future<void> completeProfile(
      String token, Map<String, dynamic> profileData) async {
    final url =
        Uri.parse('$_baseUrl/complete-profile'); //endpoint de completar perfil
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(profileData),
      );

      if (response.statusCode == 200) {
        print('Perfil completado correctamente');
      } else {
        print(
            'Error al completar el perfil: Código ${response.statusCode}, Respuesta: ${response.body}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  // Verificar el correo del usuario
  Future<void> verifyEmail(String token) async {
    final url =
        Uri.parse('$_baseUrl/verify-email'); //endpoint de verificar correo
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Correo verificado correctamente');
      } else {
        print(
            'Error al verificar correo: Código ${response.statusCode}, Respuesta: ${response.body}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }
}
