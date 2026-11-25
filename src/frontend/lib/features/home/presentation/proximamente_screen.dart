import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Pantalla de destino para las secciones que todavía no están implementadas.
class ProximamenteScreen extends StatelessWidget {
  const ProximamenteScreen({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(title: Text(titulo)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction_outlined,
                size: 48, color: AppColors.bright),
            const SizedBox(height: 16),
            const Text(
              'PRÓXIMAMENTE',
              style: TextStyle(
                fontFamily: AppTheme.headingFontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Esta pantalla todavía no está implementada.',
              style: TextStyle(fontSize: 14, color: AppColors.muted),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.bright,
                textStyle: const TextStyle(fontSize: 14),
              ),
              child: const Text('VOLVER'),
            ),
          ],
        ),
      ),
    );
  }
}
