import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthServices {
  final SupabaseClient _client = Supabase.instance.client;

  // Registro de usuario con email y contraseña
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final AuthResponse response = await _client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return response.user;
      } else {
        print("Error al registrar usuario");
        return null;
      }
    } catch (e) {
      print("Error al registrar usuario: $e");
      return null;
    }
  }

  // Inicio de sesión con email y contraseña
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final AuthResponse response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return response.user;
      } else {
        print("Error al iniciar sesión");
        return null;
      }
    } catch (e) {
      print("Error al iniciar sesión: $e");
      return null;
    }
  }
}
