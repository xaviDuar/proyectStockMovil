import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:stock_movil/core/theme/app_theme.dart';
import 'package:stock_movil/features/auth/data/auth_service.dart';
import 'package:stock_movil/features/auth/data/session_service.dart';
import 'package:stock_movil/features/auth/domain/auth_provider.dart';
import 'package:stock_movil/features/auth/presentation/login_screen.dart';
import 'package:stock_movil/features/home/presentation/home_screen.dart';

String _fontFamily(WidgetTester tester, String text) {
  final richText = tester.widget<RichText>(
    find.descendant(
      of: find.text(text),
      matching: find.byType(RichText),
    ).first,
  );
  return richText.text.style?.fontFamily ?? '';
}

void main() {
  testWidgets('login reserva DotGothic16 para marca e Inter para subtítulo',
      (tester) async {
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

    expect(_fontFamily(tester, '¿CUÁNDO VENCE?'), 'DotGothic16');
    expect(_fontFamily(tester, 'CONTROL DE STOCK'), 'Inter');
  });

  testWidgets('Home usa DotGothic16 en títulos e Inter en contenido',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: const HomeScreen(
          nombre: 'ADMIN',
          local: 'CAFETERÍA CENTRAL',
        ),
      ),
    );

    expect(_fontFamily(tester, 'INICIO'), 'DotGothic16');
    expect(_fontFamily(tester, 'ACCESOS RÁPIDOS'), 'DotGothic16');
    expect(_fontFamily(tester, 'ADMIN'), 'Inter');
  });
}
