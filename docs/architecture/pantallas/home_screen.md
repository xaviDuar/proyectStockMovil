# Pantalla de inicio (home)

- **Archivo:** `lib/features/home/presentation/home_screen.dart`
- **Estado:** implementada

## Widgets utilizados

| Widget | Tipo | Uso en la pantalla |
|--------|------|--------------------|
| `Scaffold` | Material | Estructura base con fondo `$bg` |
| `SafeArea` | Layout | Evita la barra de estado y el notch |
| `Column` | Layout | Encabezado + contenido + barra inferior |
| `Expanded` | Layout | Zona de contenido con desplazamiento |
| `SingleChildScrollView` | Layout | Scroll del contenido del panel |
| `Row` | Layout | Encabezado, tarjeta de bienvenida y tarjetas de acceso |
| `Stack` + `Positioned` | Layout | Punto rojo de notificaciones sobre la campana |
| `Container` | Layout | Tarjetas, divisor, barra inferior y paneles (bordes `$borderLight`) |
| `GridView.count` | Layout | Grilla 2×3 de accesos rápidos (relación 170/91 del mockup) |
| `InkWell` | Form | Toque en accesos rápidos y pestañas de navegación |
| `Image.asset` | Media | Mascota pixel-art (tile de marca y avatar) |
| `Icon` | Básico | Iconos de accesos, campana y navegación (equivalentes a los lucide del mockup) |
| `Text` | Básico | Títulos, saludos, textos de apoyo y recordatorio |
| `bottomNavigationBar` | Material | Barra de navegación inferior de 4 pestañas |

## Notas

- Estructura: encabezado (tile de marca + "INICIO / PANEL PRINCIPAL"), divisor, tarjeta de bienvenida (avatar + "HOLA, nombre + local" + campana con punto `$danger` + "TU STOCK, BAJO CONTROL"), grilla de 6 accesos rápidos, panel "RECORDATORIO" y navegación inferior.
- Los 6 accesos rápidos y las pestañas **Conteo / Agregar / Perfil** (y la campana) abren `ProximamenteScreen` (`lib/features/home/presentation/proximamente_screen.dart`) hasta que cada pantalla exista. La pestaña **Home** está activa (tile `$soft`, ícono `$bright`).
- Recibe `nombre` y `local` desde la sesión (`SessionService` o `AuthProvider`); no consulta la BD todavía.
- Los datos de negocio llegarán desde SQLite (`core/database/database_helper.dart`, tabla `productos`) con Provider como indica `architecture.md` §6.
- Diseño: `docs/pantallas.pen` → frame `01 Inicio`.
