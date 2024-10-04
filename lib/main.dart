import 'package:flutter/material.dart';
import 'package:notas_app/views/nota_screen.dart';

void main() {
  runApp(const NotasApp());
}

class NotasApp extends StatelessWidget {
  const NotasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotaScreen(),
    );
  }
}
