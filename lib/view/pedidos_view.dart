import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class PedidosView extends StatefulWidget {
  @override
  _PedidosViewState createState() => _PedidosViewState();
}

class _PedidosViewState extends State<PedidosView> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService firestoreService = FirestoreService();
  var txtCliente = TextEditingController();
  var txtMesa = TextEditingController();
  var txtItens = TextEditingController();
  var txtTotal = TextEditingController();
  var txtAtendente = TextEditingController(); // Novo campo para o atendente

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: txtCliente,
                decoration: InputDecoration(
                  labelText: 'Nome do Cliente',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do cliente';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: txtMesa,
                decoration: InputDecoration(
                  labelText: 'Mesa',
                  prefixIcon: Icon(Icons.table_bar),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número da mesa';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: txtItens,
                decoration: InputDecoration(
                  labelText: 'Itens do Pedido',
                  prefixIcon: Icon(Icons.list),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira os itens do pedido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: txtTotal,
                decoration: InputDecoration(
                  labelText: 'Total',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o total do pedido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField( // Novo campo para o atendente
                controller: txtAtendente,
                decoration: InputDecoration(
                  labelText: 'Atendente',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do atendente';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final dadosPedido = {
                      'cliente': txtCliente.text,
                      'mesa': txtMesa.text,
                      'itens': txtItens.text,
                      'total': txtTotal.text,
                      'atendente': txtAtendente.text, // Incluído o campo atendente nos dados do pedido
                    };

                    try {
                      await firestoreService.adicionarPedido(dadosPedido);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pedido adicionado com sucesso!')),
                      );
                      _formKey.currentState!.reset();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro ao adicionar pedido')),
                      );
                    }
                  }
                },
                child: Text('Salvar Pedido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
