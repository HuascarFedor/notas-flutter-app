import 'package:flutter/material.dart';
import 'package:notas_flutter/providers/nota_notifier.dart';
import 'package:provider/provider.dart';
import '../models/nota.dart';
import './widgets/add_dialog.dart';
import './widgets/delete_dialog.dart';

class NotaScreen extends StatefulWidget {
  const NotaScreen({super.key});

  @override
  State<NotaScreen> createState() => _NotasState();
}

class _NotasState extends State<NotaScreen> {
  // final List<Nota> _notas = [];

  @override
  Widget build(BuildContext context) {
    final notaNotifier = Provider.of<NotaNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplicación de Notas"),
      ),
      body: _buildList(notaNotifier),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNotaDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(NotaNotifier notaNotifier) {
    return ListView.builder(
      itemCount: notaNotifier.notas.length,
      itemBuilder: (context, index) {
        final Nota nota = notaNotifier.notas[index];
        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(5.0, 5.0),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              nota.content,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
            ),
            onTap: () => _showDeleteNotaDialog(notaNotifier, nota),
            trailing: const IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: null,
            ),
          ),
        );
      },
    );
  }

  void _showDeleteNotaDialog(NotaNotifier notaNotifier, Nota nota) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteDialog(
              title: "Eliminar Nota",
              content: "¿Está seguro de eliminar la nota?",
              onDelete: () {
                notaNotifier.deleteNota(nota);
              });
        });
  }

  void _showAddNotaDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddDialog(
              title: "Añadir Nueva Nota",
              decoration: "Contenido de la Nota",
              onAdd: (String text) {
                final notaNotifier =
                    Provider.of<NotaNotifier>(context, listen: false);
                notaNotifier.addNota(text);
              });
        });
  }
}
