import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'proximamente_screen.dart';

/// Panel principal — mockup `01 Inicio`.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.nombre, required this.local});

  final String nombre;
  final String local;

  void _irA(BuildContext context, String titulo) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProximamenteScreen(titulo: titulo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            const _Encabezado(),
            Container(height: 1, color: AppColors.border),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TarjetaBienvenida(nombre: nombre, local: local),
                    const SizedBox(height: 26),
                    const Text(
                      'ACCESOS RÁPIDOS',
                      style: TextStyle(
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.bright,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _GridAccesosRapidos(irA: (titulo) => _irA(context, titulo)),
                    const SizedBox(height: 14),
                    const _Recordatorio(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BarraNavegacion(
        onIrA: (titulo) => _irA(context, titulo),
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  const _Encabezado();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 10),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.bg,
              border: Border.all(color: AppColors.accent),
            ),
            child: Image.asset(
              'assets/images/mascot.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INICIO',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'PANEL PRINCIPAL',
                style: TextStyle(fontSize: 7.6, color: AppColors.muted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TarjetaBienvenida extends StatelessWidget {
  const _TarjetaBienvenida({required this.nombre, required this.local});

  final String nombre;
  final String local;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 68,
                height: 68,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Image.asset(
                  'assets/images/mascot.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'HOLA,',
                      style: TextStyle(fontSize: 9, color: AppColors.muted),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nombre.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      local,
                      style: const TextStyle(
                        fontSize: 7.2,
                        color: AppColors.bright,
                      ),
                    ),
                  ],
                ),
              ),
              const _CampanaNotificaciones(),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'TU STOCK, BAJO CONTROL',
            style: TextStyle(fontSize: 7.2, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

class _CampanaNotificaciones extends StatelessWidget {
  const _CampanaNotificaciones();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) =>
              const ProximamenteScreen(titulo: 'Notificaciones'),
        ),
      ),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.bg,
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Center(
              child: Icon(
                Icons.notifications_outlined,
                size: 18,
                color: AppColors.bright,
              ),
            ),
            Positioned(
              top: -3,
              right: -3,
              child: Container(
                width: 6,
                height: 6,
                color: AppColors.danger,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridAccesosRapidos extends StatelessWidget {
  const _GridAccesosRapidos({required this.irA});

  final void Function(String titulo) irA;

  @override
  Widget build(BuildContext context) {
    final accesos = <_Acceso>[
      _Acceso(Icons.checklist, 'VER VENCIMIENTOS', 'Revisá fechas y alertas',
          'Vencimientos'),
      _Acceso(Icons.inventory_2_outlined, 'VER STOCK', 'Consultá tus productos',
          'Stock'),
      _Acceso(Icons.checklist, 'HACER CONTEO', 'Contá tus unidades', 'Conteo'),
      _Acceso(Icons.add, 'AGREGAR PRODUCTO', 'Cargá un producto',
          'Agregar producto'),
      _Acceso(Icons.delete_outline, 'DESPERDICIO', 'Registrá pérdidas',
          'Desperdicio'),
      _Acceso(Icons.person_outline, 'VER PERFIL', 'Ajustes y sesión', 'Perfil'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 170 / 91,
      children: [
        for (final acceso in accesos)
          _TarjetaAcceso(
            acceso: acceso,
            onTap: () => irA(acceso.destino),
          ),
      ],
    );
  }
}

class _Acceso {
  const _Acceso(this.icono, this.titulo, this.texto, this.destino);

  final IconData icono;
  final String titulo;
  final String texto;
  final String destino;
}

class _TarjetaAcceso extends StatelessWidget {
  const _TarjetaAcceso({required this.acceso, required this.onTap});

  final _Acceso acceso;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          children: [
            Container(
              width: 49,
              height: 49,
              decoration: BoxDecoration(
                color: AppColors.bg,
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Icon(acceso.icono, size: 22, color: AppColors.bright),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        acceso.titulo,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        acceso.texto,
                        style: const TextStyle(
                          fontSize: 8,
                          color: AppColors.muted,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Recordatorio extends StatelessWidget {
  const _Recordatorio();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RECORDATORIO',
            style: TextStyle(
              fontSize: 7,
              fontWeight: FontWeight.bold,
              color: AppColors.warning,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Registrá el conteo al cierre del día.',
            style: TextStyle(fontSize: 8.5, color: AppColors.text),
          ),
          SizedBox(height: 6),
          Text(
            'Un control diario evita faltantes.',
            style: TextStyle(fontSize: 7.2, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

class _BarraNavegacion extends StatelessWidget {
  const _BarraNavegacion({required this.onIrA});

  final void Function(String titulo) onIrA;

  @override
  Widget build(BuildContext context) {
    const items = [
      _ItemNav(Icons.home_outlined, 'Home', esInicio: true),
      _ItemNav(Icons.checklist, 'Conteo', destino: 'Conteo'),
      _ItemNav(Icons.add, 'Agregar', destino: 'Agregar producto'),
      _ItemNav(Icons.person_outline, 'Perfil', destino: 'Perfil'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.borderLight, width: 2),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              for (final item in items)
                Expanded(
                  child: _BotonNav(
                    item: item,
                    onTap: item.esInicio
                        ? null
                        : () => onIrA(item.destino ?? item.etiqueta),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemNav {
  const _ItemNav(
    this.icono,
    this.etiqueta, {
    this.destino,
    this.esInicio = false,
  });

  final IconData icono;
  final String etiqueta;
  final String? destino;
  final bool esInicio;
}

class _BotonNav extends StatelessWidget {
  const _BotonNav({required this.item, required this.onTap});

  final _ItemNav item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final activo = item.esInicio;
    final color = activo ? AppColors.bright : AppColors.muted;

    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          color: activo ? AppColors.soft : Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.icono, size: 19, color: color),
              const SizedBox(height: 6),
              Text(
                item.etiqueta,
                style: TextStyle(fontSize: 8, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
