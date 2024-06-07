import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para adicionar dados a uma coleção específica
  Future<void> adicionarDados(String colecao, Map<String, dynamic> dados) async {
    try {
      await _firestore.collection(colecao).add(dados);
    } catch (e) {
      print('Erro ao adicionar dados: $e');
      throw Exception('Erro ao adicionar dados');
    }
  }

  // Método específico para adicionar dados à coleção 'reservas'
  Future<void> adicionarReserva(Map<String, dynamic> dados) async {
    try {
      await _firestore.collection('reservas').add(dados);
    } catch (e) {
      print('Erro ao adicionar reserva: $e');
      throw Exception('Erro ao adicionar reserva');
    }
  }

  // Método para obter um stream de reservas
  Stream<QuerySnapshot> getReservasStream() {
    return _firestore.collection('reservas').snapshots();
  }
}
