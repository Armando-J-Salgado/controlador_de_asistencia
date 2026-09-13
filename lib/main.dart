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
    Estudiante('Ana', '20247641', false),
    Estudiante('Beatriz', '20258732', false),
    Estudiante('Carlos', '20249853', false),
    Estudiante('Daniela', '20250964', false),
    Estudiante('Eduardo', '20251075', false),
    Estudiante('Fernanda', '20252186', false),
    Estudiante('Gabriel', '20253297', false),
    Estudiante('Hector', '20254308', false),
    Estudiante('Isabel', '20255419', false),
    Estudiante('Javier', '20256520', false),
    Estudiante('Karen', '20257631', false),
    Estudiante('Luis', '20258742', false),
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
