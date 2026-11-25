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

void _tamanoTelefono(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

Future<void> _cargarMascota(WidgetTester tester) async {
  await tester.runAsync(() async {
    await precacheImage(
      const AssetImage('assets/images/mascot.png'),
      tester.element(find.byType(Scaffold)),
    );
  });
  await tester.pump();
}

void main() {
  testWidgets('golden login', (tester) async {
    SharedPreferences.setMockInitialValues({});
    _tamanoTelefono(tester);
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthProvider(
          auth: AuthService(jsonFuente: '{"users":[]}'),
          sesionService: SessionService(),
        ),
        child: MaterialApp(
          theme: AppTheme.dark,
          home: const LoginScreen(),
        ),
      ),
    );
    await tester.pump();
    await _cargarMascota(tester);
    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/login.png'),
    );
  });

  testWidgets('golden home', (tester) async {
    _tamanoTelefono(tester);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: const HomeScreen(
          nombre: 'ADMIN',
          local: 'CAFETERÍA CENTRAL',
        ),
      ),
    );
    await tester.pump();
    await _cargarMascota(tester);
    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/home.png'),
    );
  });
}
