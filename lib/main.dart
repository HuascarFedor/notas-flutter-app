import 'package:flutter/material.dart';
import 'package:notas_flutter/controllers/nota_controller.dart';
import 'package:notas_flutter/providers/nota_notifier.dart';
import 'package:notas_flutter/repositories/todo_repository.dart';
import 'package:notas_flutter/services/nota_service.dart';
import 'package:provider/provider.dart';
import './views/nota_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final todoRepository = TodoRepository();
  final notaService = NotaService(todoRepository);
  final notaController = NotaController(notaService);

  runApp(
    ChangeNotifierProvider(
      create: (_) => NotaNotifier(notaController),
      child: const NotasApp(),
    ),
  );
}

class NotasApp extends StatelessWidget {
  const NotasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const NotaScreen(),
        //'/details': (context) => const NotaDetailsScreen(),
      },
    );
  }
}
