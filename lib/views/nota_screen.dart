import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/nota_notifier.dart';
import './mixins/scroll_to_last_item_mixin.dart';
import '../models/nota.dart';
import './widgets/add_dialog.dart';
import './widgets/delete_dialog.dart';

class NotaScreen extends StatefulWidget {
  const NotaScreen({super.key});

  @override
  State<NotaScreen> createState() => _NotasState();
}

class _NotasState extends State<NotaScreen> with ScrollToLastItemMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  ScrollController get scrollController => _scrollController;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
    if (notaNotifier.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (notaNotifier.notas.isEmpty) {
      return const Center(
        child: Text("Aun no hay notas"),
      );
    }
    return ListView.builder(
      controller: scrollController,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              Text(
                nota.content,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 18.0),
              ),
              const SizedBox(height: 8.0), // Espaciado
              // Subtítulo con la fecha
              Text(
                'Creado: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.parse(nota.createdAt))}',
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(height: 16.0), // Espaciado adicional
              // Acciones: Switch y Botón Eliminar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Interruptor para estado de completado
                  Row(
                    children: [
                      const Text(
                        'Completado:',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                      Switch(
                        value: nota.finished,
                        onChanged: (bool value) {
                          notaNotifier.finishedNota(nota.id!, value);
                        },
                      ),
                    ],
                  ),
                  // Botón de eliminar
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _showDeleteNotaDialog(notaNotifier, nota),
                  ),
                ],
              ),
            ],
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
                if (notaNotifier.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(notaNotifier.errorMessage!)));
                }
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
                if (notaNotifier.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(notaNotifier.errorMessage!)));
                }
                scrollToLastItem();
              });
        });
  }
}
