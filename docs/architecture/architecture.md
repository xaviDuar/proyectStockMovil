# Arquitectura de la App — Stock Móvil

> App móvil para controlar los vencimientos de las franquicias de cafetería:
> registrar vencimientos de forma rápida, ver ganancias, conteo de inventario y desperdicio del local.

---

## 1. Stack Tecnológico

| Capa | Tecnología | Por qué |
|------|-----------|---------|
| Lenguaje | **Dart** | Lenguaje moderno, tipado estático, async/await nativo, diseñado para Flutter |
| Framework | **Flutter** | SDK de Google para apps móviles multiplataforma (Android + iOS) con un solo código base |
| Plataformas objetivo | **Android e iOS** | Compilación a ambos sistemas desde el mismo proyecto |
| UI | **Widgets** | Todo en Flutter es un widget: pantallas, botones, textos, layouts |
| Red / Backend | **API REST** con paquete `http: ^1.2.0` | Solo para login: verifica el usuario contra un JSON predeterminado (sección 7). **Hoy:** el JSON está en `assets/users.json` (sin backend) |
| Serialización | **`dart:convert`** (`jsonDecode`) + modelos con `fromJson` | Mapeo tipado de JSON a clases Dart |
| Estado | **Provider** | Simple, oficial y suficiente para este tamaño de app (sección 6) |
| Persistencia local | **SQLite (`sqflite`)** + **shared_preferences** | Datos de negocio en SQLite; sesión y usuario en shared_preferences (sección 7) |

### 1.1 Dart

- Lenguaje **tipado estático** con inferencia de tipos (`var`, `final`, tipos explícitos).
- Soporte de **programación asíncrona** con `async` / `await` y `Future` / `Stream` (ideal para consultas a base de datos o red).
- **Hot reload**: cambiar código y ver el resultado en segundos sin recompilar la app completa.
- Paquete de gestión de dependencias: **pub** (`pubspec.yaml`).

### 1.2 Flutter

- Framework **declarativo**: se describe *qué* debe verse en cada estado y Flutter se encarga de pintarlo.
- **Cross-platform**: un solo código para Android e iOS, sin duplicar pantallas.
- Incluye su propio motor de renderizado (Skia/Impeller), por lo que el aspecto es **consistente** en todos los dispositivos.
- Ecosistema oficial: `flutter test`, `flutter analyze`, `flutter build apk` / `flutter build ios`.

### 1.3 El modelo de Widgets

Flutter funciona con **widgets**: componentes reutilizables que se componen entre sí para formar la interfaz.

- **Árbol de widgets**: toda la pantalla es un árbol de widgets anidados (`MaterialApp` → `Scaffold` → `AppBar`, `Body`, etc.).
- **Composición sobre herencia**: en lugar de heredar clases de UI, se componen widgets pequeños dentro de otros.
- Tipos principales:
  - `StatelessWidget` — sin estado interno (ej. un `Text`, un `Icon`, un `Card` estático).
  - `StatefulWidget` — con estado mutable que puede actualizarse (ej. un campo de formulario, un contador).
- **Reconstrucción**: cuando cambia el estado, Flutter reconstruye solo los widgets afectados.
- Widgets base que usaremos:
  - **Material Design**: `MaterialApp`, `Scaffold`, `AppBar`, `Card`, `ListTile`, `FloatingActionButton`, `TextField`, `ElevatedButton`.
  - **Layout**: `Column`, `Row`, `Stack`, `Expanded`, `Padding`, `SizedBox`.
  - **Navegación**: `Navigator` (rutas) para pasar entre pantallas.

### 1.4 Dependencias

Instalación: `flutter add http provider shared_preferences sqflite sqflite_common_ffi`

`pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0               # Cliente HTTP oficial (login contra APIREST cuando exista el backend)
  provider: ^6.1.0           # Estado (sección 6)
  shared_preferences: ^2.2.0 # Sesión y usuario logueado (sección 7)
  sqflite: ^2.4.1            # BD local SQLite — datos de negocio (sección 7)
  sqflite_common_ffi: ^2.3.4 # SQLite en escritorio (Windows/Linux/macOS) y en tests
```

`android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

---

## 2. Capa de Red: Consumo de APIs REST

En esta app la API REST se usa **únicamente para el login** (verificación de usuario, sección 7); los datos de negocio son locales (sección 7). El flujo arquitectónico del servidor a la pantalla:

```
1. Petición HTTP          → Request con Uri y Headers usando el paquete `http`
2. Respuesta String JSON  → http.Response validando estrictamente statusCode == 200
3. Deserialización        → jsonDecode + mapeo a clases modelo (factory fromJson)
4. Renderizado reactivo   → FutureBuilder muestra carga, error o datos
```

### 2.1 Modelo de datos (JSON → Dart)

Serialización tipada con **factory constructors**:

```dart
// Archivo: user_model.dart
class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  // Convierte un Map de JSON en una instancia UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}
```

### 2.2 Capa de red (servicio asíncrono)

```dart
// Archivo: api_service.dart
class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((item) => UserModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar usuarios desde la API');
    }
  }
}
```

### 2.3 UI reactiva con `FutureBuilder`

Maneja los tres estados de un `AsyncSnapshot`:

| Estado | Condición | UI |
|--------|-----------|-----|
| Cargando | `connectionState == ConnectionState.waiting` | `CircularProgressIndicator` |
| Error | `snapshot.hasError` | Mensaje de error |
| Con datos | `snapshot.hasData` | `ListView.builder` con los items |
| Vacío | caso por defecto | "Sin datos" |

### 2.4 Reglas de oro (prevención de bugs)

1. **Nunca pedir en `build()`** — invocar la función HTTP dentro de `build()` genera peticiones infinitas en cada redibujo.
2. **Guardar el `Future` en `initState()`** — garantiza que la API se invoque **una sola vez** en el ciclo de vida del widget.
3. **No olvidar `async` / `await`** — acceder a `.body` antes de que se resuelva el `Future` provoca errores de null.

---

## 3. Arquitectura por Capas

Organizamos el código en capas separadas para que sea fácil de probar y mantener:

```
┌─────────────────────────────────────────────┐
│  PRESENTACIÓN (UI)                          │
│  Widgets / Pantallas — Flutter              │
│  Muestra datos y captura eventos del usuario│
├─────────────────────────────────────────────┤
│  ESTADO (State Management)                  │
│  Notifica a la UI cuando los datos cambian  │
├─────────────────────────────────────────────┤
│  LÓGICA DE NEGOCIO (Domain)                 │
│  Reglas: vencimientos, inventario,          │
│  ganancias, desperdicio                     │
├─────────────────────────────────────────────┤
│  DATOS (Data)                               │
│  Repositorios sobre SQLite (datos de        │
│  negocio) + API REST solo para login        │
└─────────────────────────────────────────────┘
```

Reglas:

1. Los **widgets** solo dibujan y delegan: no contienen reglas de negocio.
2. La **lógica de negocio** no conoce Flutter ni los widgets (pura Dart → fácil de unit-testear).
3. La **capa de datos** expone repositorios (`VencimientoRepository`, `InventarioRepository`, …) que leen y escriben en SQLite (datos de negocio); solo el login consume la API REST. El resto del código consume sin saber de dónde vienen los datos.

---

## 4. Estructura de Carpetas Propuesta

```
proyectoStockMovil/
├── docs/
│   ├── architecture/
│   │   ├── architecture.md        ← este documento
│   │   └── pantallas/             ← un .md por pantalla implementada
│   └── pantallas.pen              ← diseño de pantallas
├── overview.md                    ← visión general del producto
└── src/
    ├── frontend/                  ← proyecto Flutter (stock_movil)
    │   ├── pubspec.yaml           ← dependencias Dart/Flutter
    │   └── lib/
    │       ├── main.dart          ← punto de entrada
    │       ├── app.dart           ← MaterialApp, tema, puerta de sesión
    │       ├── features/          ← una carpeta por módulo
    │       │   ├── auth/          ← login (JSON/API REST) y sesión
    │       │   │   ├── data/          ← auth_service, session_service, user_model
    │       │   │   ├── domain/        ← auth_provider (estado con Provider)
    │       │   │   └── presentation/  ← login_screen
    │       │   ├── home/          ← panel principal
    │       │   │   └── presentation/  ← home_screen, proximamente_screen
    │       │   ├── vencimientos/
    │       │   │   ├── data/          ← repositorios SQLite, modelos
    │       │   │   ├── domain/        ← modelos y reglas de negocio
    │       │   │   └── presentation/  ← widgets y pantallas (Provider)
    │       │   ├── inventario/
    │       │   ├── ganancias/
    │       │   └── desperdicio/
    │       └── core/              ← tema, database_helper (SQLite), formatos de fecha
    └── backend/                   ← (futuro) backend
```

---

## 5. Flujo de Datos

### 5.1 Login (único flujo con red)

```
Usuario introduce usuario y contraseña
        │
        ▼
ApiService envía credenciales a la API REST (sección 2)
        │
        ▼
La API verifica que el usuario exista en el JSON predeterminado
(admin / admin123)
        │
        ├── No coincide → mensaje de error en el login
        │
        ▼
Coincide → guardar sesión en shared_preferences → entrar a la app
```

### 5.2 Datos de negocio (todo local)

```
Usuario toca la pantalla
        │
        ▼
Widget (UI) emite un evento
        │
        ▼
Capa de estado (Provider) / lógica de negocio procesa la regla
        │
        ▼
Repositorio → lee/escribe en SQLite (local, sin red)
        │
        ▼
El estado cambia y notifica a la UI
        │
        ▼
Flutter reconstruye los widgets afectados
```

---

## 6. Estado — Provider (decidido)

Se usa **Provider**:

- Simple, oficial de Flutter y suficiente para el tamaño de esta app.
- Riverpod no aportaría nada extra aquí; Bloc sería estructura de más.
- Patrón: los datos cambian desde la lógica de negocio/repositorios → Provider notifica → la UI se reconstruye.

---

## 7. Persistencia — Local-first (decidido)

**Los datos de negocio son 100% locales:** la app funciona sin conexión para vencimientos, inventario, ganancias y desperdicio (las franquicias a veces están sin señal).

| Qué | Dónde | Por qué |
|-----|-------|---------|
| Datos de negocio (vencimientos, inventario, ganancias, desperdicio) | **SQLite (`sqflite`)** | BD local consultable y robusta; `sqflite_common_ffi` la hace correr también en escritorio y en tests |
| Sesión y usuario logueado | **shared_preferences** | Datos simples clave-valor tras el login |

> **Implementado hoy:** `lib/core/database/database_helper.dart` abre `stock_movil.db`
> (migración v1 con la tabla `productos`) y cambia a `sqflite_common_ffi` en
> Windows/Linux/macOS. En web SQLite no está disponible todavía (ninguna pantalla
> actual la necesita).

**Único flujo con red — login:**

1. El usuario introduce usuario y contraseña.
2. `AuthService` (hoy) carga `assets/users.json` y valida las credenciales; la
   forma del servicio es la del `ApiService` (sección 2), de modo que al existir
   el backend solo se reemplaza la carga del asset por `http.get`.
3. La verificación compara contra un **JSON predeterminado** (`admin` / `admin123`); no almacena usuarios.
4. Si coincide → se guarda la sesión en `shared_preferences` y la app queda abierta.
5. Si no → mensaje de error en el login.

La sesión se cierra desde la pantalla de **Perfil** (logout).

---

## 8. Calidad de Código

- **Análisis estático**: `flutter analyze` con el linter oficial (`flutter_lints`).
- **Pruebas**:
  - Unit tests para la lógica de negocio (vencimientos, inventario, ganancias, desperdicio).
  - Widget tests para pantallas críticas.
- **Control de versiones**: Git, con ramas por feature.

---

## 9. Herramientas de Desarrollo

| Herramienta | Uso |
|-------------|-----|
| Flutter SDK | Compilar, ejecutar y testear la app |
| Dart SDK | Lenguaje (incluido en Flutter SDK) |
| Android Studio / VS Code | Editor con extensiones oficiales de Flutter |
| Git | Control de versiones |
| Emulador Android / dispositivo real | Ejecución y pruebas |
