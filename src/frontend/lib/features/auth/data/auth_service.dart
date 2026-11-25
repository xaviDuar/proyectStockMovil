import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'user_model.dart';

/// Verificación de usuario (único flujo con "red" de la app).
///
/// Hoy valida contra el JSON fijo `assets/users.json` (`admin` / `admin123`),
/// como describe `docs/architecture/architecture.md` (sección 7). La forma
/// del servicio es la misma que tendría el `ApiService` contra la API REST:
/// al existir el backend basta con reemplazar la carga del asset por
/// `http.get` manteniendo la firma de [verificarAcceso].
class AuthService {
  AuthService({this.jsonFuente});

  static const rutaAsset = 'assets/users.json';

  /// JSON inyectable para los tests (evita cargar el asset).
  final String? jsonFuente;

  Future<UserModel?> verificarAcceso(
    String usuario,
    String contrasena,
  ) async {
    final datos = jsonFuente ?? await rootBundle.loadString(rutaAsset);

    final cuerpo = jsonDecode(datos) as Map<String, dynamic>;
    final usuarios = (cuerpo['users'] as List<dynamic>)
        .map((item) => UserModel.fromJson(item as Map<String, dynamic>));

    final usuarioLimpio = usuario.trim();
    for (final u in usuarios) {
      if (u.username == usuarioLimpio && u.password == contrasena) {
        return u;
      }
    }
    return null;
  }
}
