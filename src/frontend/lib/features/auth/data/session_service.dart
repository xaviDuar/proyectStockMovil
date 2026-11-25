import 'package:shared_preferences/shared_preferences.dart';

import 'user_model.dart';

/// Datos de la sesión guardada en `shared_preferences` (architecture.md §7).
class Sesion {
  const Sesion({
    required this.usuario,
    required this.nombre,
    required this.local,
  });

  final String usuario;
  final String nombre;
  final String local;
}

class SessionService {
  static const _claveUsuario = 'usuario_logueado';
  static const _claveNombre = 'usuario_nombre';
  static const _claveLocal = 'usuario_local';

  Future<void> guardarSesion(UserModel usuario) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_claveUsuario, usuario.username);
    await prefs.setString(_claveNombre, usuario.name);
    await prefs.setString(_claveLocal, usuario.local);
  }

  Future<Sesion?> leerSesion() async {
    final prefs = await SharedPreferences.getInstance();
    final usuario = prefs.getString(_claveUsuario);
    if (usuario == null) return null;
    return Sesion(
      usuario: usuario,
      nombre: prefs.getString(_claveNombre) ?? usuario.toUpperCase(),
      local: prefs.getString(_claveLocal) ?? '',
    );
  }

  Future<void> cerrarSesion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_claveUsuario);
    await prefs.remove(_claveNombre);
    await prefs.remove(_claveLocal);
  }
}
