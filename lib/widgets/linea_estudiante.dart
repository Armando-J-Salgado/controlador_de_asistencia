import 'package:control_de_asistencia/widgets/tabla.dart';
import 'package:flutter/material.dart';

class LineaEstudiante extends StatefulWidget {
  const LineaEstudiante({super.key, required this.estudiante, required this.onAsistenciaCambiada});
  final Estudiante estudiante;
  final VoidCallback onAsistenciaCambiada;

  @override
  State<StatefulWidget> createState() => _EstadoLineaEstudiante();
}

class _EstadoLineaEstudiante extends State<LineaEstudiante> {

  void _marcarAsistencia() {
    widget.estudiante.asistencia = !widget.estudiante.asistencia;
    setState(() {});
    widget.onAsistenciaCambiada();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.estudiante}")
          ],),
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: _marcarAsistencia, child: widget.estudiante.asistencia ? Icon(Icons.check) : Icon(Icons.cancel))
          ],)
        ],
        ),
      );
  }
}