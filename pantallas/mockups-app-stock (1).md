# Mockups de app móvil para gestión de stock

Quiero que diseñes los mockups de una aplicación móvil para gestión de stock, vencimientos, conteo, estadísticas y desperdicio de productos.

La interfaz debe ser moderna, clara, intuitiva y pensada principalmente para utilizarse desde un teléfono móvil. Quiero que cada pantalla mantenga una estética y un sistema de navegación coherentes entre sí.

> **IMPORTANTE:** en cada pantalla que diseñes, señalá mediante flechas qué widgets de Flutter utilizarías para implementar cada elemento importante de la interfaz. Por ejemplo: `AppBar`, `Column`, `Row`, `Container`, `Card`, `ListView`, `BottomNavigationBar`, `FloatingActionButton`, `TextField`, `IconButton`, etc. Las flechas deben indicar visualmente qué widget corresponde a cada componente.

---

## 1. Pantalla HOME

La pantalla principal debe tener:

- En la parte superior, centrado visualmente, una sección de bienvenida.
- A la izquierda debe aparecer un pequeño personaje/monigote que represente al usuario.
- A la derecha del personaje debe aparecer:
  - "Hola"
  - Debajo, el nombre del usuario actual.
- En la esquina superior derecha debe haber un ícono de notificaciones.

Debajo de la bienvenida habrá dos botones grandes, ocupando prácticamente todo el ancho disponible.

### Botón 1: Ver vencimientos

- Debe estar dentro de un recuadro.
- A la izquierda debe tener un ícono relacionado con una lista.
- A la derecha del ícono debe decir: "Ver vencimientos".

### Botón 2: Ver stock

- Debe estar dentro de un recuadro.
- A la izquierda debe tener un ícono que represente un estante con productos.
- A la derecha debe decir: "Ver stock".

### Barra de navegación inferior

Todas las pantallas deben utilizar la misma barra de navegación inferior.

Debe tener 6 opciones:

1. 🏠 **Home**
   - Ícono: casa.
2. 📋 **Conteo**
   - Ícono: lista con puntos.
3. ➕ **Agregar producto**
   - Ícono: símbolo "+".
   - Permite agregar un nuevo producto.
4. 📊 **Estadísticas**
   - Ícono relacionado con estadísticas/gráficos.
5. 🗑️ **Desperdicio**
   - Ícono: tacho de basura.
6. 👤 **Perfil**
   - Ícono: perfil de usuario.

La barra debe permanecer visualmente consistente en todas las pantallas.

---

## 2. Pantalla "Ver vencimientos"

Esta pantalla muestra una lista vertical de productos.

Cada producto debe aparecer como una tarjeta o fila horizontal dentro de una lista vertical.

Cada elemento debe mostrar:

- Nombre del producto.
- Cuánto tiempo falta para su vencimiento o cuánto tiempo lleva vencido.
- Estado del producto.

La información debe ser clara y fácil de leer.

En la parte superior debe existir una barra de búsqueda para encontrar rápidamente un producto.

La pantalla debe mantener la barra de navegación inferior común a toda la aplicación.

La lista puede ser estática para el mockup.

---

## 3. Pantalla "Ver stock"

Esta pantalla también debe mostrar los productos mediante una lista vertical de elementos horizontales.

Cada producto debe mostrar información relevante sobre el stock.

Los productos deben estar diferenciados mediante colores según su estado:

- 🔴 **Rojo:** producto vencido.
- 🟡 **Amarillo:** producto próximo a vencer.
- 🟢 **Verde:** producto que todavía no está vencido.

Debe existir una barra de búsqueda en la parte superior para encontrar rápidamente productos.

La barra de navegación inferior debe mantenerse igual que en el resto de las pantallas.

---

## 4. Pantalla "Conteo"

Esta pantalla se utiliza para realizar el conteo de productos al final del día.

Debe permitir ir agregando productos progresivamente.

La interfaz debe mostrar una lista de productos y permitir aumentar la cantidad mediante un botón "+".

La idea es que el usuario pueda:

- Seleccionar/agregar un producto.
- Indicar la cantidad.
- Aumentar o disminuir cantidades.
- Ir cargando todos los productos del conteo del día.

Debe ser una interfaz rápida y sencilla, pensada para utilizarse mientras se realiza un inventario.

Mantener la barra de navegación inferior.

---

## 5. Pantalla "Agregar producto"

Esta pantalla se abre desde el botón "+" de la barra de navegación.

Debe contener un formulario para ingresar un nuevo producto.

Los datos solicitados son:

- Nombre del producto.
- Fecha de ingreso.
- Estado.
- Cantidad.

Utilizar campos de formulario claros y botones adecuados para guardar/cancelar.

La pantalla debe ser sencilla y cómoda para introducir información desde un teléfono.

Mantener la barra de navegación inferior.

---

## 6. Pantalla "Estadísticas"

Esta pantalla debe mostrar información visual sobre el rendimiento del negocio.

Debe incluir un gráfico, preferentemente de líneas o barras, que permita visualizar la evolución de los datos.

Debajo del gráfico debe aparecer información resumida, por ejemplo:

- Ganancias del día.
- Ganancias acumuladas.
- Pérdidas.
- Otros indicadores relevantes.

Podés agregar métricas adicionales si ayudan a que la pantalla sea más completa, siempre manteniendo una interfaz limpia.

Mantener la barra de navegación inferior.

---

## 7. Pantalla "Desperdicio"

Esta pantalla debe utilizar una lógica similar a la pantalla de "Conteo", pero enfocada exclusivamente en los productos desperdiciados.

Debe permitir registrar:

- Producto desperdiciado.
- Cantidad.
- Motivo del desperdicio, si corresponde.
- Fecha.

También debe mostrar un historial del desperdicio registrado, pudiendo incluir información del día actual y de días anteriores.

La pantalla debe permitir agregar rápidamente nuevos desperdicios.

Mantener la barra de navegación inferior.

---

## 8. Pantalla "Perfil"

Esta pantalla debe mostrar la información del usuario actual.

Debe incluir:

- Nombre del usuario.
- Imagen/avatar.
- Opciones para modificar el nombre.
- Configuraciones generales.
- Otras opciones útiles que consideres apropiadas para una aplicación de gestión de stock.

Podés inventar opciones adicionales siempre que tengan sentido para la aplicación.

Mantener la barra de navegación inferior.

---

## Reglas generales de diseño

1. Todas las pantallas deben pertenecer visualmente a la misma aplicación.
2. Mantener una estética moderna, limpia y profesional.
3. Diseñar pensando específicamente en dispositivos móviles.
4. Mantener márgenes, tamaños, tipografías, botones y tarjetas consistentes.
5. Utilizar íconos intuitivos y fáciles de reconocer.
6. La barra de navegación inferior debe ser exactamente la misma en todas las pantallas.
7. Las listas deben ser fáciles de escanear visualmente.
8. Los estados mediante colores deben utilizarse de manera consistente.
9. No sobrecargar las pantallas con información innecesaria.
10. Priorizar una buena experiencia de usuario y navegación rápida.

---

## Flutter

En cada mockup quiero que señales con flechas los widgets de Flutter que serían necesarios para construir la interfaz.

Por ejemplo:

- `AppBar` → barra superior.
- `Row` → elementos colocados horizontalmente.
- `Column` → elementos colocados verticalmente.
- `Container` → contenedores y secciones.
- `Card` → tarjetas de productos.
- `ListView` → listas de productos.
- `Text` → textos.
- `Icon` / `IconButton` → íconos.
- `TextField` → campos de entrada.
- `ElevatedButton` / `FilledButton` → botones.
- `BottomNavigationBar` o `NavigationBar` → navegación inferior.
- `FloatingActionButton` → acciones principales.
- `DropdownButton` / `DropdownButtonFormField` → selección de opciones.
- `DatePicker` → selección de fechas.
- `LinearProgressIndicator` o gráficos → indicadores visuales.
- `Form` → formularios.

No es necesario limitarse a estos widgets: si otro widget de Flutter resulta más apropiado para una determinada pantalla, señalalo.

---

## Dudas antes de empezar

Si tenés alguna duda importante antes de generar los mockups, utilizá "Ask User Question". En caso de tener una duda, dividila en tres preguntas importantes relacionadas con esa duda para obtener toda la información necesaria antes de continuar.

---

## Objetivo final

El objetivo final es obtener mockups suficientemente detallados como para que posteriormente puedan utilizarse como referencia directa para desarrollar la aplicación en Flutter.
