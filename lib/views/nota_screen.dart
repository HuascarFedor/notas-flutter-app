import 'package:flutter/material.dart';
import '../models/nota.dart';
import './widgets/add_dialog.dart';
import './widgets/delete_dialog.dart';

class NotaScreen extends StatefulWidget {
  const NotaScreen({super.key});

  @override
  State<NotaScreen> createState() => _NotasState();
}

class _NotasState extends State<NotaScreen> {
  final List<Nota> _notas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplicación de Notas"),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNotaDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: _notas.length,
      itemBuilder: (context, index) {
        final Nota nota = _notas[index];
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
            onTap: () => _showDeleteNotaDialog(index),
            trailing: const IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: null,
            ),
          ),
        );
      },
    );
  }

  void _showDeleteNotaDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteDialog(
              title: "Eliminar Nota",
              content: "¿Está seguro de eliminar la nota?",
              onDelete: () {
                setState(() {
                  _notas.removeAt(index);
                });
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
                setState(() {
                  _notas.add(Nota(content: text));
                });
              });
        });
  }
}
