import 'package:control_de_asistencia/widgets/linea_estudiante.dart';
import 'package:flutter/material.dart';

///Representa un estudiante
class Estudiante {
  final String nombre;
  final String carnet;
  bool asistencia = false;
  Estudiante(this.nombre,this.carnet,this.asistencia);

  @override
  String toString() {
    return "Nombre: $nombre \nCarnet: $carnet";
  }
}

///Widget con estado de la lista de asistencia
class Tabla extends StatefulWidget {
  const Tabla ({super.key, required this.estudiantes});
  final List<Estudiante> estudiantes;

  @override
  State<StatefulWidget> createState() => _EstadoTabla();
}

///Estado manejado y renderizado
class _EstadoTabla extends State<Tabla> {
  late int asistencias;

  @override
  void initState() {
    super.initState();

    asistencias = widget.estudiantes.where((estudiante)=>estudiante.asistencia).length;
  }

  void _refrescarEstado() {
    setState(() {
      asistencias = widget.estudiantes.where((estudiante)=>estudiante.asistencia).length;
    });
  }

  void _reiniciarEstado() {
    for(var i = 0; i < widget.estudiantes.length; i++) {
      widget.estudiantes[i].asistencia = false;
    }
    _refrescarEstado();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Asistencia'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 20,
                children: [
                  Text("$asistencias"),
                  ElevatedButton(onPressed: _reiniciarEstado, child: Icon(Icons.cancel))
                ]
              ),
            ]),
            Expanded(
            child:ListView.builder(
              itemCount: widget.estudiantes.length,
              itemBuilder: (context, indice) {
                return LineaEstudiante(estudiante: widget.estudiantes[indice], onAsistenciaCambiada: _refrescarEstado,);//revisar
              },
            ),
            )
          ],
        )
      );
  }
}