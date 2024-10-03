import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'aws-0-sa-east-1.pooler.supabase.com';

  // Registro de usuario con email y contraseña
  Future<Map<String, dynamic>?> signUpWithEmailAndPassword(
      String email, String password) async {
    final url = Uri.parse('$_baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error al registrar usuario: ${response.body}");
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
    final url = Uri.parse('$_baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error al iniciar sesión: ${response.body}");
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
    final url = Uri.parse('$_baseUrl/complete-profile');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(profileData),
      );

      if (response.statusCode == 200) {
        print('Perfil completado correctamente');
      } else {
        print('Error al completar el perfil: ${response.body}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  // Verificar el correo del usuario
  Future<void> verifyEmail(String token) async {
    final url = Uri.parse('$_baseUrl/verify-email');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        print('Correo verificado correctamente');
      } else {
        print('Error al verificar correo: ${response.body}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }
}
