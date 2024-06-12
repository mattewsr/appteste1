import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class MesasView extends StatefulWidget {
  @override
  _MesasViewState createState() => _MesasViewState();
}

class _MesasViewState extends State<MesasView> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService firestoreService = FirestoreService();
  var txtNumeroMesa = TextEditingController();
  var txtCapacidade = TextEditingController();
  var txtHorario = TextEditingController();
  var txtTipoRefeicao = TextEditingController();
  var txtAtendente = TextEditingController();
  var txtArea = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesas'),
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
                controller: txtNumeroMesa,
                decoration: InputDecoration(
                  labelText: 'Número da Mesa',
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
                controller: txtCapacidade,
                decoration: InputDecoration(
                  labelText: 'Capacidade',
                  prefixIcon: Icon(Icons.people),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a capacidade da mesa';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: txtHorario,
                decoration: InputDecoration(
                  labelText: 'Horário',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o horário';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: txtTipoRefeicao,
                decoration: InputDecoration(
                  labelText: 'Tipo de Refeição',
                  prefixIcon: Icon(Icons.food_bank),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o tipo de refeição';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
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
              TextFormField(
                controller: txtArea,
                decoration: InputDecoration(
                  labelText: 'Área',
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a área (interna ou externa)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final dadosMesa = {
                      'numeroMesa': txtNumeroMesa.text,
                      'capacidade': txtCapacidade.text,
                      'horario': txtHorario.text,
                      'tipoRefeicao': txtTipoRefeicao.text,
                      'atendente': txtAtendente.text,
                      'area': txtArea.text,
                    };

                    try {
                      await firestoreService.adicionarMesa(dadosMesa);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mesa adicionada com sucesso!')),
                      );
                      _formKey.currentState!.reset();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro ao adicionar mesa')),
                      );
                    }
                  }
                },
                child: Text('Salvar Mesa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
