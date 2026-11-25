# Pantalla de inicio de sesión

- **Archivo:** `lib/features/auth/presentation/login_screen.dart`
- **Estado:** implementada

## Widgets utilizados

| Widget | Tipo | Uso en la pantalla |
|--------|------|--------------------|
| `Scaffold` | Material | Estructura base con fondo `$bg` |
| `SafeArea` | Layout | Evita la barra de estado y el notch |
| `SingleChildScrollView` | Layout | Desplazamiento cuando aparece el teclado |
| `Column` | Layout | Disposición vertical del formulario |
| `ConstrainedBox` | Layout | Ancho máximo del formulario (pantallas grandes) |
| `Image.asset` | Media | Mascota pixel-art (`assets/images/mascot.png`) como logo |
| `Text` | Básico | Títulos, etiquetas de campo y mensajes |
| `TextField` | Form | Campos de usuario y contraseña (iconos `person_outline` / `lock_outline`) |
| `IconButton` | Básico | Mostrar/ocultar contraseña (icono `eye` del mockup) |
| `ElevatedButton` | Form | Botón "INICIAR SESIÓN" con borde `$accent` y fondo `$soft` |
| `CircularProgressIndicator` | Básico | Estado de verificación (spinner dentro del botón) |
| `Container` | Layout | Panel de mensaje de error/validación |
| `Consumer` implícito (`context.watch`) | Provider | Lee el estado de `AuthProvider` (verificando) |
| `context.read` | Provider | Dispara `AuthProvider.iniciarSesion` |

## Notas

- Tipografía: `DotGothic16` para el título de marca; `Inter` para subtítulo, campos, botones y mensajes. Los textos de lectura se mantienen entre 12 y 16sp.
- Tres estados de error, igual que los mockups:
  - `00.2 campos vacíos` → panel `$soft` con texto en `$warning`: "Ingresá usuario y contraseña" (validación local, sin llamar al servicio).
  - `00.1 credenciales incorrectas` → panel `#321d25` con texto en `$danger`: "Usuario o contraseña incorrectos".
  - Fallo del servicio → mensaje genérico en `$danger`.
- Estado cargando: botón deshabilitado con spinner mientras `AuthService` verifica (la duración es la real de la carga del JSON, sin demoras artificiales).
- La verificación se hace contra `assets/users.json` (`admin` / `admin123`) mediante `AuthService`, con la misma forma que el `ApiService` de `architecture.md` §2: al existir el backend se reemplaza la carga del asset por `http.get` sin tocar la pantalla.
- Sesión guardada en `shared_preferences` (`SessionService`) y restaurada por `_PuertaSesion` en `lib/app.dart`.
- Éxito → `pushReplacement` a `HomeScreen` (no se puede volver al login con "atrás").
- Flujo: `LoginScreen` → `AuthProvider` (estado) → `AuthService` (verificación) / `SessionService` (persistencia).
