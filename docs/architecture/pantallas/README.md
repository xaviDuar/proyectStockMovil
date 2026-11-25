# Pantallas

Para **cada pantalla implementada** se crea un archivo Markdown en esta carpeta
listando los widgets de Flutter que se utilizan en ella.

## Convención de nombres

- Un archivo por pantalla, en `snake_case`, igual al nombre del archivo `.dart`:
  - Pantalla de login → `login_screen.md` → `lib/features/auth/presentation/login_screen.dart`
  - Lista de vencimientos → `vencimientos_screen.md`

## Plantilla

```markdown
# <Nombre de la pantalla>

- **Archivo:** `lib/features/<feature>/presentation/<pantalla>.dart`
- **Estado:** pendiente | en progreso | implementada

## Widgets utilizados

| Widget | Tipo | Uso en la pantalla |
|--------|------|--------------------|
| `Scaffold` | Material | Estructura base |
| `AppBar` | Material | Barra superior con título |
| `ListView.builder` | Layout | Lista de elementos |

## Notas
- Decisiones relevantes, estados (loading/error/vacío), etc.
```
