import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_movil/core/theme/app_theme.dart';

void main() {
  test('usa Inter para texto y DotGothic16 para encabezados', () {
    final theme = AppTheme.dark;

    expect(theme.textTheme.bodyMedium?.fontFamily, 'Inter');
    expect(theme.textTheme.headlineSmall?.fontFamily, 'DotGothic16');
    expect(theme.textTheme.titleMedium?.fontFamily, 'Inter');
    expect(theme.appBarTheme.titleTextStyle?.fontFamily, 'DotGothic16');
    expect(
      theme.elevatedButtonTheme.style?.textStyle?.resolve({})?.fontFamily,
      'Inter',
    );
  });

  testWidgets('incluye ambas familias y los pesos de Inter en el bundle',
      (tester) async {
    final manifest =
        jsonDecode(await rootBundle.loadString('FontManifest.json')) as List;
    final fonts = manifest.cast<Map<String, dynamic>>();
    final dotGothic = fonts.singleWhere(
      (font) => font['family'] == 'DotGothic16',
    );
    final inter = fonts.singleWhere((font) => font['family'] == 'Inter');

    expect((dotGothic['fonts'] as List).single['weight'], 400);
    final interWeights = (inter['fonts'] as List)
        .map((font) => (font as Map<String, dynamic>)['weight'] as int)
        .toList();
    expect(interWeights, containsAll(<int>[400, 500, 600, 700]));
  });
}
