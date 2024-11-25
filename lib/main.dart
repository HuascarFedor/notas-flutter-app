import 'package:flutter/material.dart';
import 'package:notas_flutter/controllers/nota_controller.dart';
import 'package:notas_flutter/providers/nota_notifier.dart';
import 'package:notas_flutter/repositories/todo_repository.dart';
import 'package:notas_flutter/services/nota_service.dart';
import 'package:provider/provider.dart';
import './views/nota_screen.dart';

void main() {
  runApp(const NotasApp());
}

class NotasApp extends StatelessWidget {
  const NotasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          NotaNotifier(NotaController(NotaService(TodoRepository()))),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NotaScreen(),
      ),
    );
  }
}
