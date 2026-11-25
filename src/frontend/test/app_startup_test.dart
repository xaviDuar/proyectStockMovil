import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_movil/app.dart';
import 'package:stock_movil/features/auth/data/auth_service.dart';
import 'package:stock_movil/features/auth/data/session_service.dart';
import 'package:stock_movil/features/auth/domain/auth_provider.dart';
import 'package:stock_movil/features/auth/presentation/login_screen.dart';

void main() {
  testWidgets('muestra el login cuando termina de cargar sin sesión',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final sesion = SessionService();

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthProvider(
          auth: AuthService(),
          sesionService: sesion,
        ),
        child: StockMovilApp(sesion: sesion),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
