import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_movil/core/theme/app_theme.dart';
import 'package:stock_movil/features/home/presentation/home_screen.dart';
import 'package:stock_movil/features/home/presentation/proximamente_screen.dart';

Widget _pantallaHome() {
  return MaterialApp(
    theme: AppTheme.dark,
    home: const HomeScreen(
      nombre: 'ADMIN',
      local: 'CAFETERÍA CENTRAL',
    ),
  );
}

/// Las pantallas están diseñadas a 390×844 (mockup `01 Inicio`).
void _configurarTamanioTelefono(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('muestra encabezado, bienvenida y accesos rápidos',
      (tester) async {
    _configurarTamanioTelefono(tester);
    await tester.pumpWidget(_pantallaHome());

    expect(find.text('INICIO'), findsOneWidget);
    expect(find.text('PANEL PRINCIPAL'), findsOneWidget);
    expect(find.text('ADMIN'), findsOneWidget);
    expect(find.text('CAFETERÍA CENTRAL'), findsOneWidget);
    expect(find.text('ACCESOS RÁPIDOS'), findsOneWidget);
    expect(find.text('VER VENCIMIENTOS'), findsOneWidget);
    expect(find.text('VER STOCK'), findsOneWidget);
    expect(find.text('HACER CONTEO'), findsOneWidget);
    expect(find.text('AGREGAR PRODUCTO'), findsOneWidget);
    expect(find.text('DESPERDICIO'), findsOneWidget);
    expect(find.text('VER PERFIL'), findsOneWidget);
    expect(find.text('RECORDATORIO'), findsOneWidget);
  });

  testWidgets('accesos rápidos y navegación llevan al placeholder',
      (tester) async {
    _configurarTamanioTelefono(tester);
    await tester.pumpWidget(_pantallaHome());

    await tester.tap(find.text('HACER CONTEO'));
    await tester.pumpAndSettle();

    expect(find.byType(ProximamenteScreen), findsOneWidget);
    expect(find.text('PRÓXIMAMENTE'), findsOneWidget);
  });
}
