import 'package:flutter/foundation.dart';

import '../data/auth_service.dart';
import '../data/session_service.dart';

enum EstadoAcceso { inicial, verificando, autenticado, rechazado }

/// Estado del acceso: orquesta [AuthService] (verificación) y
/// [SessionService] (guardado de sesión), y notifica a la UI con Provider.
class AuthProvider extends ChangeNotifier {
  AuthProvider({required this.auth, required this.sesionService});

  final AuthService auth;
  final SessionService sesionService;

  EstadoAcceso estado = EstadoAcceso.inicial;
  String? mensajeError;
  Sesion? sesion;

  bool get verificando => estado == EstadoAcceso.verificando;

  Future<bool> iniciarSesion(String usuario, String contrasena) async {
    estado = EstadoAcceso.verificando;
    mensajeError = null;
    notifyListeners();

    try {
      final user = await auth.verificarAcceso(usuario, contrasena);
      if (user == null) {
        estado = EstadoAcceso.rechazado;
        mensajeError = 'Usuario o contraseña incorrectos';
        notifyListeners();
        return false;
      }
      await sesionService.guardarSesion(user);
      sesion = Sesion(
        usuario: user.username,
        nombre: user.name,
        local: user.local,
      );
      estado = EstadoAcceso.autenticado;
      notifyListeners();
      return true;
    } catch (e) {
      estado = EstadoAcceso.rechazado;
      mensajeError = 'No se pudo verificar el acceso. Intentá de nuevo.';
      notifyListeners();
      return false;
    }
  }

  Future<void> restaurarSesion() async {
    sesion = await sesionService.leerSesion();
    estado =
        sesion != null ? EstadoAcceso.autenticado : EstadoAcceso.inicial;
    notifyListeners();
  }

  Future<void> cerrarSesion() async {
    await sesionService.cerrarSesion();
    sesion = null;
    estado = EstadoAcceso.inicial;
    mensajeError = null;
    notifyListeners();
  }
}
