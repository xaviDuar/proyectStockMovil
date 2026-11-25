import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:stock_movil/core/database/database_helper.dart';

void main() {
  sqfliteFfiInit();

  test('crea la tabla productos y guarda registros', () async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final helper = DatabaseHelper(ruta: inMemoryDatabasePath);

    final id = await helper.insertarProducto({
      'nombre': 'Leche entera',
      'categoria': 'Lácteos',
      'cantidad': 12,
      'unidad': 'lt',
    });
    expect(id, greaterThan(0));

    final productos = await helper.listarProductos();
    expect(productos, hasLength(1));
    expect(productos.single['nombre'], 'Leche entera');
    expect(productos.single['cantidad'], 12);

    await helper.cerrar();
  });
}
