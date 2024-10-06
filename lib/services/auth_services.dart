import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://localhost:8080';
  final String _apiKey = 'AIzaSyDwYTh9EH6Q7C3RGaKcM2Jkc63Q4Mbv3wM';
  // Registro de usuario con nombres, apellidos, email y contraseña
  Future<Map<String, dynamic>?> signUpWithDetails(
      String firstName, String lastName, String email, String password) async {
    final url =
        Uri.parse('$_baseUrl/register'); //endpoint de registro de usuario
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'apikey': _apiKey, // Aquí incluimos el API Key
        },
        body: jsonEncode({
          'nombres': firstName,
          'apellidos': lastName,
          'email': email,
          'password': password
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(
            "Error al registrar usuario: Código de estado: ${response.statusCode}, Respuesta: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error al registrar usuario: $e");
      return null;
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
          'apikey': _apiKey, // Aquí incluimos el API Key
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
          'apikey': _apiKey, // Aquí incluimos el API Key
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
          'apikey': _apiKey, // Aquí incluimos el API Key
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
