import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_movil/core/theme/app_theme.dart';
import 'package:stock_movil/features/auth/data/auth_service.dart';
import 'package:stock_movil/features/auth/data/session_service.dart';
import 'package:stock_movil/features/auth/domain/auth_provider.dart';
import 'package:stock_movil/features/auth/presentation/login_screen.dart';
import 'package:stock_movil/features/home/presentation/home_screen.dart';

/// Mismo contenido que `assets/users.json` (la carga real desde el asset se
/// cubre en `auth_service_test.dart`).
const _jsonUsuarios = '''
{
  "users": [
    {
      "id": 1,
      "username": "admin",
      "password": "admin123",
      "name": "ADMIN",
      "local": "CAFETERÍA CENTRAL"
    }
  ]
}
''';

Widget _pantallaLogin() {
  return ChangeNotifierProvider(
    create: (_) => AuthProvider(
      auth: AuthService(jsonFuente: _jsonUsuarios),
      sesionService: SessionService(),
    ),
    child: MaterialApp(
      theme: AppTheme.dark,
      home: const LoginScreen(),
    ),
  );
}

Future<void> _escribirCredenciales(
  WidgetTester tester,
  String usuario,
  String contrasena,
) async {
  await tester.enterText(find.byType(TextField).at(0), usuario);
  await tester.enterText(find.byType(TextField).at(1), contrasena);
}

Future<void> _verificar(WidgetTester tester) async {
  await tester.tap(find.text('INICIAR SESIÓN'));
  // Procesa la verificación (sincrónica con JSON inyectado) y el guardado
  // de la sesión en shared_preferences.
  await tester.pump();
  // Deja terminar la transición de ruta al home, si la hay.
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pump();
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('muestra el formulario de login', (tester) async {
    await tester.pumpWidget(_pantallaLogin());

    expect(find.text('¿CUÁNDO VENCE?'), findsOneWidget);
    expect(find.text('CONTROL DE STOCK'), findsOneWidget);
    expect(find.text('USUARIO'), findsOneWidget);
    expect(find.text('CONTRASEÑA'), findsOneWidget);
    expect(find.text('INICIAR SESIÓN'), findsOneWidget);
  });

  testWidgets('al enviar campos vacíos muestra el aviso de warning',
      (tester) async {
    await tester.pumpWidget(_pantallaLogin());

    await tester.tap(find.text('INICIAR SESIÓN'));
    await tester.pump();

    expect(find.text('Ingresá usuario y contraseña'), findsOneWidget);
    expect(find.text('Usuario o contraseña incorrectos'), findsNothing);
  });

  testWidgets('con credenciales válidas entra al home', (tester) async {
    await tester.pumpWidget(_pantallaLogin());

    await _escribirCredenciales(tester, 'admin', 'admin123');
    await _verificar(tester);

    expect(find.text('INICIO'), findsOneWidget);
    expect(find.text('PANEL PRINCIPAL'), findsOneWidget);
    expect(find.text('ADMIN'), findsOneWidget);
    expect(find.text('ACCESOS RÁPIDOS'), findsOneWidget);
  });

  testWidgets('con credenciales incorrectas muestra el error en danger',
      (tester) async {
    await tester.pumpWidget(_pantallaLogin());

    await _escribirCredenciales(tester, 'admin', 'otra-clave');
    await _verificar(tester);

    expect(find.text('Usuario o contraseña incorrectos'), findsOneWidget);
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
  });
}
