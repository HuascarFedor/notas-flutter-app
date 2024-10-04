import 'package:flutter/material.dart';

void main() {
  runApp(const NotasApp());
}

class NotasApp extends StatelessWidget {
  const NotasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Notas(),
    );
  }
}

class Notas extends StatefulWidget {
  const Notas({super.key});

  @override
  State<Notas> createState() => _NotasState();
}

class _NotasState extends State<Notas> {
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
    return ListView(
      children: <Widget>[
        for(int i=0; i<10; i++) ...[
          Container(
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
                'Nota ${i + 1}',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
              ),
              onTap: null,
              trailing: const IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent),
                onPressed: null,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
