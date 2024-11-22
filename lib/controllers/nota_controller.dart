import 'package:notas_flutter/models/nota.dart';
import 'package:notas_flutter/services/nota_service.dart';
import 'package:notas_flutter/utils/list_utils.dart';

class NotaController {
  final NotaService _notaService;

  NotaController(this._notaService);

  final _notas = <Nota>[];

  List<Nota> get notas => List.unmodifiable(_notas);

  Future<void> loadNotas() async {
    try {
      _notas.clear();
      final loadedNotas = await _notaService.getNotas();
      if (loadedNotas.isNotEmpty) _notas.addAll(loadedNotas);
    } catch (e) {
      throw Exception("Error al cargar las notas: $e");
    }
  }

  Future<void> addNota(String content) async {
    if (content.isEmpty) content = 'Sin contenido';
    content = ListUtils.checkForDuplicates(
        notas.map((nota) => nota.content), content);
    try {
      int id = await _notaService.addNota(Nota(content: content));
      _notas.add(Nota(id: id, content: content));
    } catch (e) {
      throw Exception("Error al añadir una nota: $e");
    }
  }

  Future<void> deleteNota(Nota nota) async {
    try {
      await _notaService.deleteNota(nota);
    } catch (e) {
      throw Exception("Error al eliminar la nota: $e");
    } finally {
      _notas.removeWhere((item) => item.id == nota.id);
    }
  }
}
