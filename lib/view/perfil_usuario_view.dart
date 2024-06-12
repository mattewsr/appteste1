import 'package:flutter/material.dart';

class PerfilUsuarioView extends StatefulWidget {
  @override
  _PerfilUsuarioViewState createState() => _PerfilUsuarioViewState();
}

class _PerfilUsuarioViewState extends State<PerfilUsuarioView> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Aqui você pode inicializar os controladores com os dados do perfil do usuário
    _nomeController.text = 'Nome do usuário';
    _emailController.text = 'email@example.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditarPerfilView()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(_nomeController.text),
            SizedBox(height: 20.0),
            Text(
              'E-mail:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(_emailController.text),
          ],
        ),
      ),
    );
  }
}

class EditarPerfilView extends StatefulWidget {
  @override
  _EditarPerfilViewState createState() => _EditarPerfilViewState();
}

class _EditarPerfilViewState extends State<EditarPerfilView> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Aqui você pode inicializar os controladores com os dados atuais do perfil do usuário
    _nomeController.text = 'Nome do usuário';
    _emailController.text = 'email@example.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode salvar as alterações no perfil do usuário
                // Por exemplo, pode enviar os dados para o Firebase Firestore ou outra fonte de dados
                Navigator.pop(context); // Fecha a tela de edição
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
