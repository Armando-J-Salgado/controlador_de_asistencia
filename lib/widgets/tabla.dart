import 'package:control_de_asistencia/widgets/linea_estudiante.dart';
import 'package:flutter/material.dart';

///Representa un estudiante
class Estudiante {
  final String nombre;
  final String carnet;
  bool asistencia = false;
  Estudiante(this.nombre, this.carnet, this.asistencia);

  @override
  String toString() {
    return "Nombre: $nombre \nCarnet: $carnet";
  }
}

///Widget con estado de la lista de asistencia
class Tabla extends StatefulWidget {
  const Tabla({super.key, required this.estudiantes});
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

    asistencias = widget.estudiantes
        .where((estudiante) => estudiante.asistencia)
        .length;
  }

  void _refrescarEstado() {
    setState(() {
      asistencias = widget.estudiantes
          .where((estudiante) => estudiante.asistencia)
          .length;
    });
  }

  void _reiniciarEstado() {
    for (var i = 0; i < widget.estudiantes.length; i++) {
      widget.estudiantes[i].asistencia = false;
    }
    _refrescarEstado();
  }

  void _marcarTodos() {
    for (var i = 0; i < widget.estudiantes.length; i++) {
      widget.estudiantes[i].asistencia = true;
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
          Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'NUESTRO EQUIPO',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$asistencias / ${widget.estudiantes.length} presentes',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _marcarTodos,
                          icon: const Icon(Icons.check_circle_outline, size: 16),
                          label: const Text('Marcar todos', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _reiniciarEstado,
                          icon: const Icon(Icons.restart_alt, size: 16),
                          label: const Text('Restablecer', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.estudiantes.length,
              itemBuilder: (context, indice) {
                return LineaEstudiante(
                  estudiante: widget.estudiantes[indice],
                  onAsistenciaCambiada: _refrescarEstado,
                ); //revisar
              },
            ),
          ),
        ],
      ),
    );
  }
}
