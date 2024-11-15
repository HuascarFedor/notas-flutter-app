import 'package:notas_flutter/models/nota.dart';
import 'package:notas_flutter/utils/list_utils.dart';

class NotaController {
  final _notas = <Nota>[];

  List<Nota> get notas => List.unmodifiable(_notas);

  void addNota(String content) {
    if (content.isEmpty) content = 'Sin contenido';
    content = ListUtils.checkForDuplicates(
        notas.map((nota) => nota.content), content);
    _notas.add(Nota(content: content));
  }

  void deleteNota(Nota nota) {
    _notas.remove(nota);
  }
}
