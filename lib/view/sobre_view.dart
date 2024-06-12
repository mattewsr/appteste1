// sobre_view.dart

import 'package:flutter/material.dart';

class SobreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
      ),
      body: Center(
        child: Text('esse aplicativo foi desnevolvido para atender um sistema de reservas e recepção para um restaurante desenvolvido na aula de desenvolvimento movel por matheus rossi '),
      ),
    );
  }
}
