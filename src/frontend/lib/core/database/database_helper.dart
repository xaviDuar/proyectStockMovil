import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Acceso a la base de datos local SQLite (datos de negocio).
///
/// - Android/iOS: el plugin `sqflite` registra su fábrica nativa.
/// - Windows/Linux/macOS y tests: `sqflite_common_ffi` (SQLite vía FFI).
/// - Web: SQLite todavía no está disponible; [database] lanza [UnsupportedError].
class DatabaseHelper {
  DatabaseHelper({String? ruta}) : _rutaPropia = ruta;

  /// Instancia única de la app.
  static final DatabaseHelper instancia = DatabaseHelper();

  static const nombreArchivo = 'stock_movil.db';
  static const versionEsquema = 1;

  static bool _plataformaConfigurada = false;

  final String? _rutaPropia;
  Database? _db;

  static void _configurarPlataforma() {
    if (_plataformaConfigurada || kIsWeb) return;
    final plataforma = defaultTargetPlatform;
    final esEscritorio = plataforma == TargetPlatform.windows ||
        plataforma == TargetPlatform.linux ||
        plataforma == TargetPlatform.macOS;
    if (esEscritorio) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    _plataformaConfigurada = true;
  }

  Future<Database> get database async {
    if (kIsWeb) {
      throw UnsupportedError('SQLite no está disponible en web todavía.');
    }
    _configurarPlataforma();
    final existente = _db;
    if (existente != null) return existente;

    final ruta =
        _rutaPropia ?? join(await getDatabasesPath(), nombreArchivo);
    final db = await openDatabase(
      ruta,
      version: versionEsquema,
      onCreate: _crearTablas,
    );
    _db = db;
    return db;
  }

  Future<void> _crearTablas(Database db, int version) async {
    await db.execute('''
      CREATE TABLE productos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        categoria TEXT,
        fecha_vencimiento TEXT,
        cantidad INTEGER NOT NULL DEFAULT 0,
        unidad TEXT,
        actualizado_en TEXT NOT NULL DEFAULT (datetime('now'))
      )
    ''');
  }

  Future<int> insertarProducto(Map<String, dynamic> producto) async {
    final db = await database;
    return db.insert('productos', producto);
  }

  Future<List<Map<String, dynamic>>> listarProductos() async {
    final db = await database;
    return db.query('productos', orderBy: 'nombre');
  }

  Future<void> cerrar() async {
    final db = _db;
    _db = null;
    if (db != null) await db.close();
  }
}
