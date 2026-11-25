# AGENTS.md

## Qué es este repo

App móvil (Flutter) para controlar vencimientos de franquicias de cafetería:
registrar vencimientos, ver ganancias, conteo de inventario y desperdicio.

- Idioma: **español**. Documentos, comentarios y respuestas en español.
- El proyecto Flutter está en `src/frontend/` (nombre: `stock_movil`).
  Hoy están implementadas la **login** y la **home** (con pantalla
  "Próximamente" para el resto de módulos). `src/backend/` está vacío.
- Rama actual: `DocumentacionCreate`.

## Mapa de carpetas y archivos

```
proyectoStockMovil/
├── AGENTS.md                     ← este archivo: reglas para agentes
├── overview.md                   ← visión del producto (2 líneas de qué hace la app)
├── docs/
│   ├── architecture/
│   │   ├── architecture.md       ← FUENTE DE VERDAD: stack, decisiones, capas, flujo
│   │   └── pantallas/
│   │       ├── README.md         ← plantilla:1 pantalla implementada = 1 .md con sus widgets
│   │       ├── login_screen.md   ← widgets de la pantalla de login (implementada)
│   │       └── home_screen.md    ← widgets de la home (implementada)
│   └── pantallas.pen             ← diseño de pantallas (solo vía MCP pencil; NO leer con Read/Grep)
└── src/
    ├── frontend/                 ← proyecto Flutter (stock_movil)
    │   ├── lib/
    │   │   ├── main.dart         ← arranque: registra AuthProvider (Provider)
    │   │   ├── app.dart          ← MaterialApp + puerta de sesión (si hay sesión, entra al home)
    │   │   ├── core/
    │   │   │   ├── database/database_helper.dart  ← SQLite (sqflite / sqflite_common_ffi)
    │   │   │   └── theme/app_theme.dart           ← tema oscuro y colores (AppColors)
    │   │   └── features/
    │   │       ├── auth/         ← data/ (auth_service, session_service, user_model),
    │   │       │                   domain/ (auth_provider), presentation/ (login_screen)
    │   │       └── home/presentation/  ← home_screen + proximamente_screen (placeholder)
    │   ├── assets/               ← users.json (credenciales), images/mascot.png, fonts/
    │   └── test/                 ← 14 tests (auth, home, widget, database, goldens)
    └── backend/                  ← (vacío) aquí irá el backend
```

Qué leer y cuándo:

| Archivo | Cuándo consultarlo |
|---------|--------------------|
| `overview.md` | Cualquier duda sobre qué hace la app |
| `docs/architecture/architecture.md` | **Antes de implementar**: stack, estructura `lib/features/`, reglas de red, persistencia |
| `docs/architecture/pantallas/README.md` | Al crear una pantalla: convención de nombres y plantilla del `.md` de widgets |
| `docs/architecture/pantallas/login_screen.md` y `home_screen.md` | Ejemplos ya hechos de la plantilla |
| `docs/pantallas.pen` | Solo para ver/validar diseños, usando las herramientas MCP pencil |

⚠️ `architecture.md` sección 4 muestra el proyecto Flutter en la raíz; la
estructura real es `src/frontend/`. No crear el proyecto en la raíz.

## Decisiones ya tomadas (no re-litigar)

Detalle completo en `docs/architecture/architecture.md`:

- **Login = único flujo con red** (API REST + `http`, credenciales contra JSON
  fijo `admin`/`admin123`). Hoy la validación se hace contra
  `assets/users.json` local (sin backend); todo lo demás es local.
- Estado con **Provider**; persistencia con **SQLite** (`sqflite`, datos de
  negocio) y **shared_preferences** (sesión).
- Arquitectura por capas: `presentation` / `domain` / `data` dentro de cada
  feature en `lib/features/` (ver secciones 3 y 4 de `architecture.md`).

## Comandos

```powershell
cd src\frontend                    # todos los comandos de Flutter van aquí
flutter pub get                    # tras tocar pubspec.yaml
flutter run -d chrome              # ver la app (también: -d edge, -d windows)
flutter analyze && flutter test    # verificación mínima (14 tests, deben pasar)
```

Flutter 3.47.8 instalado. Dispositivos: Chrome, Edge, Windows. No hay
emulador Android ni Android Studio detectados — `flutter run -d windows` o
`-d chrome` para desarrollo local. Si se pide Android, verificar con
`flutter doctor` antes de asumir que funciona.

## Reglas al implementar

- Proyecto Flutter **dentro de `src/frontend/`**, nunca en la raíz.
- Al crear cada pantalla, crear su `.md` en `docs/architecture/pantallas/`
  siguiendo la plantilla de `pantallas/README.md`.
- Mantener los tests en verde: `flutter analyze` sin errores y
  `flutter test` completo antes de dar por terminado un cambio.
- Los goldens (`test/goldens/*.png`) se regeneran solo si el diseño de la
  pantalla cambia a propósito.
