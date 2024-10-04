import 'package:flutter/material.dart';
import 'package:notas_app/views/widgets/delete_dialog.dart';

class NotaScreen extends StatefulWidget {
  const NotaScreen({super.key});

  @override
  State<NotaScreen> createState() => _NotasState();
}

class _NotasState extends State<NotaScreen> {
  final List<String> _notas = ["nota 1", "NOTA 2", "HOLA"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplicación de Notas"),
      ),
      body: _buildList(),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: _notas.length,
      itemBuilder: (context, index) {
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
              _notas[index],
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
              onDelete: () {});
        });
  }
}
