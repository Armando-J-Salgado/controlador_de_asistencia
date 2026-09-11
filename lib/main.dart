import 'package:control_de_asistencia/widgets/tabla.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yawi',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.indigoAccent),
      ),
      home: const MyHomePage(title: 'Yawi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  List<Estudiante> estudiantes = [
    Estudiante('Armando', '20245138', true),
    Estudiante('José', '20256589', false),
    Estudiante('Gerardo', '20246378', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical:10),
        child: Tabla(estudiantes: estudiantes)),
    );
  }
}
