import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../domain/auth_provider.dart';
import '../../home/presentation/home_screen.dart';

enum _TipoError { vacio, credenciales }

/// Pantalla de inicio de sesión — mockup `00 Inicio de sesión`
/// (más los estados `00.1 credenciales incorrectas` y `00.2 campos vacíos`).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usuarioCtrl = TextEditingController();
  final _contrasenaCtrl = TextEditingController();
  bool _ocultarContrasena = true;
  _TipoError? _tipoError;
  String? _mensaje;

  @override
  void dispose() {
    _usuarioCtrl.dispose();
    _contrasenaCtrl.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    final usuario = _usuarioCtrl.text.trim();
    final contrasena = _contrasenaCtrl.text;

    if (usuario.isEmpty || contrasena.isEmpty) {
      setState(() {
        _tipoError = _TipoError.vacio;
        _mensaje = 'Ingresá usuario y contraseña';
      });
      return;
    }

    setState(() {
      _tipoError = null;
      _mensaje = null;
    });

    final auth = context.read<AuthProvider>();
    final ok = await auth.iniciarSesion(usuario, contrasena);
    if (!mounted) return;

    if (ok) {
      final sesion = auth.sesion;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => HomeScreen(
            nombre: sesion?.nombre ?? usuario.toUpperCase(),
            local: sesion?.local ?? 'CAFETERÍA CENTRAL',
          ),
        ),
      );
      return;
    }

    setState(() {
      _tipoError = _TipoError.credenciales;
      _mensaje = auth.mensajeError ?? 'Usuario o contraseña incorrectos';
    });
  }

  @override
  Widget build(BuildContext context) {
    final verificando = context.watch<AuthProvider>().verificando;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 32, 18, 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    '¿CUÁNDO VENCE?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppTheme.headingFontFamily,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bright,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'CONTROL DE STOCK',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: AppColors.muted),
                  ),
                  const SizedBox(height: 44),
                  const _Etiqueta('USUARIO'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _usuarioCtrl,
                    enabled: !verificando,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 16, color: AppColors.text),
                    decoration: const InputDecoration(
                      hintText: 'Tu usuario',
                      prefixIcon: Icon(Icons.person_outline, size: 19),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const _Etiqueta('CONTRASEÑA'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _contrasenaCtrl,
                    enabled: !verificando,
                    obscureText: _ocultarContrasena,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => verificando ? null : _enviar(),
                    style: const TextStyle(fontSize: 16, color: AppColors.text),
                    decoration: InputDecoration(
                      hintText: 'Tu contraseña',
                      prefixIcon: const Icon(Icons.lock_outline, size: 18),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _ocultarContrasena
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 18,
                        ),
                        onPressed: verificando
                            ? null
                            : () => setState(
                                  () =>
                                      _ocultarContrasena = !_ocultarContrasena,
                                ),
                      ),
                    ),
                  ),
                  if (_mensaje != null) ...[
                    const SizedBox(height: 20),
                    _PanelMensaje(
                      mensaje: _mensaje!,
                      esErrorDeCredenciales:
                          _tipoError == _TipoError.credenciales,
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 54,
                    child: ElevatedButton(
                      onPressed: verificando ? null : _enviar,
                      child: verificando
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.bright,
                              ),
                            )
                          : const Text('INICIAR SESIÓN'),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'ACCESO PARA PERSONAL AUTORIZADO',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppColors.muted),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Etiqueta extends StatelessWidget {
  const _Etiqueta(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
        letterSpacing: 1,
      ),
    );
  }
}

class _PanelMensaje extends StatelessWidget {
  const _PanelMensaje({required this.mensaje, required this.esErrorDeCredenciales});

  final String mensaje;
  final bool esErrorDeCredenciales;

  @override
  Widget build(BuildContext context) {
    final color =
        esErrorDeCredenciales ? AppColors.danger : AppColors.warning;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      color: esErrorDeCredenciales
          ? AppColors.dangerPanel
          : AppColors.soft,
      child: Text(
        mensaje,
        style: TextStyle(fontSize: 14, color: color),
      ),
    );
  }
}
