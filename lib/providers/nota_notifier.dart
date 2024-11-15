import 'package:flutter/material.dart';
import 'package:notas_flutter/controllers/nota_controller.dart';
import 'package:notas_flutter/models/nota.dart';

class NotaNotifier extends ChangeNotifier {
  final NotaController _notaController;

  NotaNotifier(this._notaController);

  List<Nota> get notas => _notaController.notas;

  void addNota(String content) {
    _notaController.addNota(content);
    notifyListeners();
  }

  void deleteNota(Nota nota) {
    _notaController.deleteNota(nota);
    notifyListeners();
  }
}
