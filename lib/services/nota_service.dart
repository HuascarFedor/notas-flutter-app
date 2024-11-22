import 'package:notas_flutter/models/nota.dart';
import 'package:notas_flutter/repositories/todo_repository.dart';

class NotaService {
  final TodoRepository _todoRepository;

  NotaService(this._todoRepository);

  Future<List<Nota>> getNotas() async {
    return await _todoRepository.getAllNotas();
  }

  Future<int> addNota(Nota nota) async {
    return await _todoRepository.insertNota(nota);
  }

  Future<void> deleteNota(Nota nota) async {
    await _todoRepository.deleteNota(nota);
  }
}
