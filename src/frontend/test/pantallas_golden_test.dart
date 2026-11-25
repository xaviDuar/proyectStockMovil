import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FontLoader, rootBundle;
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

bool _fuentesCargadas = false;

Future<void> _cargarFuentes(WidgetTester tester) async {
  if (_fuentesCargadas) return;
  await tester.runAsync(_cargarFuentesLocales);
  _fuentesCargadas = true;
  await tester.pump();
}

Future<void> _cargarFuentesLocales() async {
  final fuentes = {
    'DotGothic16': 'assets/fonts/DotGothic16-Regular.ttf',
    'Inter': 'assets/fonts/Inter-Variable.ttf',
  };
  for (final entry in fuentes.entries) {
    final loader = FontLoader(entry.key)
      ..addFont(rootBundle.load(entry.value));
    await loader.load();
  }
}

Future<void> _cargarImagen(WidgetTester tester, String asset) async {
  await tester.runAsync(() async {
    await precacheImage(
      AssetImage(asset),
      tester.element(find.byType(Scaffold)),
    );
  });
  await tester.pump();
}

void main() {
  testWidgets('golden login', (tester) async {
    SharedPreferences.setMockInitialValues({});
    _tamanoTelefono(tester);
    await _cargarFuentes(tester);
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
    await _cargarImagen(tester, 'assets/images/logo.png');
    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/login.png'),
    );
  });

  testWidgets('golden home', (tester) async {
    _tamanoTelefono(tester);
    await _cargarFuentes(tester);
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
    await _cargarImagen(tester, 'assets/images/mascot.png');
    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/home.png'),
    );
  });
}
