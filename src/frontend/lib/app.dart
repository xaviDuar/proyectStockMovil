import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/data/session_service.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/home/presentation/home_screen.dart';

class StockMovilApp extends StatelessWidget {
  const StockMovilApp({super.key, this.sesion});

  /// Inyectable para los tests.
  final SessionService? sesion;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '¿Cuándo Vence?',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: _PuertaSesion(sesion: sesion ?? SessionService()),
    );
  }
}

/// Si hay sesión guardada entra directo al home; si no, muestra el login.
class _PuertaSesion extends StatelessWidget {
  const _PuertaSesion({required this.sesion});

  final SessionService sesion;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Sesion?>(
      future: sesion.leerSesion(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: AppColors.bg,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            ),
          );
        }
        final guardada = snapshot.data;
        if (guardada == null) return const LoginScreen();
        return HomeScreen(
          nombre: guardada.nombre,
          local: guardada.local,
        );
      },
    );
  }
}
