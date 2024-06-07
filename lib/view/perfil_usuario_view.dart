// perfil_usuario_view.dart

import 'package:flutter/material.dart';

class PerfilUsuarioView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
      ),
      body: Center(
        child: Text('Detalhes do perfil do usuário.'),
      ),
    );
  }
}
