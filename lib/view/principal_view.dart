// principal_view.dart

import 'package:flutter/material.dart';
import 'reservas_view.dart';
import 'perfil_usuario_view.dart';
import 'sobre_view.dart';

class PrincipalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principal'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'reservas');
              },
              child: Text('Reservas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'perfilUsuario');
              },
              child: Text('Perfil do Usuário'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'sobre');
              },
              child: Text('Sobre'),
            ),
          ],
        ),
      ),
    );
  }
}
