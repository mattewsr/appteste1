import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class ReservasView extends StatefulWidget {
  @override
  _ReservasViewState createState() => _ReservasViewState();
}

class _ReservasViewState extends State<ReservasView> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService firestoreService = FirestoreService();
  var txtNomeCliente = TextEditingController();
  var txtMesa = TextEditingController();
  var txtTelefone = TextEditingController();
  var txtQuantidadePessoas = TextEditingController();
  var txtHorarioReserva = TextEditingController();
  DateTime? _selectedDate;
  String _searchTerm = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: const Locale('pt', 'BR'),
    );

    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null)
      setState(() {
        txtHorarioReserva.text = pickedTime.format(context);
      });
  }

  void _searchReservas(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm;
    });
  }

  void _editReserva(Map<String, dynamic> reservaData) {
    setState(() {
      txtNomeCliente.text = reservaData['nomeCliente'];
      txtMesa.text = reservaData['mesa'];
      txtTelefone.text = reservaData['telefone'];
      txtQuantidadePessoas.text = reservaData['quantidadePessoas'];
      txtHorarioReserva.text = reservaData['horarioReserva'];
      _selectedDate = reservaData['dataReserva'].toDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservas'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  searchCallback: _searchReservas,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: txtNomeCliente,
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
                controller: txtTelefone,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: txtQuantidadePessoas,
                decoration: InputDecoration(
                  labelText: 'Quantidade de Pessoas',
                  prefixIcon: Icon(Icons.people),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade de pessoas';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: TextEditingController(
                  text: _selectedDate == null
                      ? ''
                      : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                ),
                decoration: InputDecoration(
                  labelText: 'Data da Reserva',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione a data da reserva';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: txtHorarioReserva,
                decoration: InputDecoration(
                  labelText: 'Horário da Reserva',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(),
                ),
                onTap: () {
                  _selectTime(context);
                },
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione o horário da reserva';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final dadosReserva = {
                      'nomeCliente': txtNomeCliente.text,
                      'mesa': txtMesa.text,
                      'telefone': txtTelefone.text,
                      'quantidadePessoas': txtQuantidadePessoas.text,
                      'dataReserva': Timestamp.fromDate(_selectedDate!),
                      'horarioReserva': txtHorarioReserva.text,
                    };

                    try {
                      await firestoreService.adicionarReserva(dadosReserva);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Reserva adicionada com sucesso!')),
                      );
                      // Limpar os campos após o sucesso
                      _formKey.currentState!.reset();
                      setState(() {
                        _selectedDate = null;
                        txtHorarioReserva.clear();
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro ao adicionar reserva')),
                      );
                    }
                  }
                },
                child: Text('Salvar Reserva'),
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: firestoreService.getReservasStream(searchTerm: _searchTerm),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}');
                  } else {
                    final reservas = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: reservas.length,
                      itemBuilder: (context, index) {
                        final reserva = reservas[index].data() as Map<String, dynamic>;
                        return ListTile(
                          leading: Icon(Icons.event),
                          title: Text(reserva['nomeCliente']),
                          subtitle: Text(DateFormat('dd/MM/yyyy').format(reserva['dataReserva'].toDate())),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editReserva(reserva);
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final Function(String) searchCallback;

  CustomSearchDelegate({required this.searchCallback});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchCallback(query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
