import 'package:flutter_test/flutter_test.dart';
import 'package:stock_movil/features/auth/data/auth_service.dart';

const _jsonUsuarios = '''
{
  "users": [
    {
      "id": 1,
      "username": "admin",
      "password": "admin123",
      "name": "ADMIN",
      "local": "CAFETERÍA CENTRAL"
    }
  ]
}
''';

void main() {
  AuthService servicio() => AuthService(jsonFuente: _jsonUsuarios);

  test('acepta las credenciales válidas del JSON', () async {
    final usuario = await servicio().verificarAcceso('admin', 'admin123');

    expect(usuario, isNotNull);
    expect(usuario!.username, 'admin');
    expect(usuario.name, 'ADMIN');
    expect(usuario.local, 'CAFETERÍA CENTRAL');
  });

  test('rechaza una contraseña incorrecta', () async {
    final usuario = await servicio().verificarAcceso('admin', 'incorrecta');

    expect(usuario, isNull);
  });

  test('rechaza un usuario inexistente', () async {
    final usuario = await servicio().verificarAcceso('otro', 'admin123');

    expect(usuario, isNull);
  });

  test('ignora los espacios alrededor del usuario', () async {
    final usuario = await servicio().verificarAcceso('  admin ', 'admin123');

    expect(usuario, isNotNull);
  });

  testWidgets('carga las credenciales desde assets/users.json',
      (tester) async {
    final usuario = await AuthService().verificarAcceso('admin', 'admin123');

    expect(usuario, isNotNull);
    expect(usuario!.username, 'admin');
    expect(usuario.local, 'CAFETERÍA CENTRAL');
  });
}
