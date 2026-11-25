import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'features/auth/data/auth_service.dart';
import 'features/auth/data/session_service.dart';
import 'features/auth/domain/auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(
        auth: AuthService(),
        sesionService: SessionService(),
      ),
      child: const StockMovilApp(),
    ),
  );
}
