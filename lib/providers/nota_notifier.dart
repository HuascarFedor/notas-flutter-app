import 'package:flutter/material.dart';
import 'package:notas_flutter/controllers/nota_controller.dart';
import 'package:notas_flutter/models/nota.dart';

class NotaNotifier extends ChangeNotifier {
  final NotaController _notaController;
  bool _isLoading = false;
  String? _errorMessage;

  NotaNotifier(this._notaController) {
    _loadNotas();
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Nota> get notas => _notaController.notas;
  int get notasCount => notas.length;

  Future<void> _loadNotas() async {
    try {
      _isLoading = true;
      notifyListeners();
      await _notaController.loadNotas();
    } catch (_) {
      _errorMessage = "No se pudieron cargar los planes";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNota(String content) async {
    try {
      _errorMessage = null;
      notifyListeners();
      await _notaController.addNota(content);
    } catch (_) {
      _errorMessage = "Error al añadir la nota";
    }
    notifyListeners();
  }

  Future<void> deleteNota(Nota nota) async {
    try {
      _errorMessage = null;
      notifyListeners();
      await _notaController.deleteNota(nota);
    } catch (_) {
      _errorMessage = "Error al eliminar la nota";
    }
    notifyListeners();
  }
}
