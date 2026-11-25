# Tipografía de la aplicación — diseño

## Intención

Reemplazar Workbench para que la app tenga títulos con identidad visual y textos de lectura cómodos en pantallas móviles.

## Alcance

- DotGothic16 para títulos principales y encabezados de pantalla/sección.
- Inter para texto corrido, subtítulos, formularios, botones, etiquetas y mensajes.
- Aplicar la jerarquía a las pantallas implementadas actualmente (login, Home y placeholders) mediante el tema compartido y estilos explícitos donde corresponda.
- Aumentar los textos que hoy están en 7–9 px cuando sean demasiado pequeños para leerse cómodamente; conservar la composición y el estilo visual existentes.
- Actualizar documentación y pruebas visuales para reflejar la tipografía aprobada.

## Enfoque aprobado

1. **Fuentes locales empaquetadas (elegido):** añadir los archivos de DotGothic16 e Inter a `assets/fonts` y declararlos en `pubspec.yaml`. La app funcionará sin red y no mostrará una fuente de reemplazo mientras descarga.
2. **Cargar con Google Fonts en ejecución:** descartado porque añade dependencia de red y no es coherente con la arquitectura local-first.

La fuente secundaria elegida es **Inter**, por su legibilidad como tipografía de interfaz. DotGothic16 se reserva para títulos, no para párrafos o textos de control.

## Restricciones y decisiones de implementación

- Mantener el tema oscuro, colores, navegación y distribución actuales; el alcance es tipográfico.
- Usar DotGothic16 Regular para encabezados, ya que la familia ofrece un único peso.
- Empaquetar la fuente variable Inter para texto normal y énfasis; incluir licencias de las fuentes.
- Usar tamaños de texto móvil legibles en lugar de conservar literalmente los tamaños diminutos de Workbench; como guía, cuerpo 14–16sp, texto auxiliar 12–14sp y títulos 18–24sp, ajustados a cada componente.
- No borrar los archivos Workbench existentes; dejarán de estar declarados/usados por el tema.

## Validación

- `flutter analyze` y `flutter test`.
- Actualizar y verificar los goldens de las pantallas cuyo aspecto tipográfico cambie.
- `flutter build web` para comprobar que los archivos locales de fuentes estén incluidos.

## Fuera de alcance

- Rediseñar colores, iconos, navegación o contenido.
- Cargar fuentes desde internet durante la ejecución.
