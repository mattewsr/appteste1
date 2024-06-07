// reserva_detalhes_view.dart

import 'package:flutter/material.dart';

class ReservaDetalhesView extends StatelessWidget {
  final String nomeReserva;

  const ReservaDetalhesView({required this.nomeReserva});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Reserva'),
      ),
      body: Center(
        child: Text('Detalhes da reserva: $nomeReserva'),
      ),
    );
  }
}
