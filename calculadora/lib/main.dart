import 'package:flutter/material.dart';
// Importando o componente Display
import 'package:calculadora/components/display.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(
            child: Text(
              'Calculadora',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        // Usando o componente Display
        body: const Display(),
      ),
    );
  }
}