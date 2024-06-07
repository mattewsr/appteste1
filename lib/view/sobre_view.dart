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
        child: Text('Informações sobre o aplicativo.'),
      ),
    );
  }
}
