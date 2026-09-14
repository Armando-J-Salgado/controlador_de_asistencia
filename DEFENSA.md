# Defensa técnica

## Estado y ubicación

Pregunta textual
> ¿Dónde vive el estado de su pantalla y por qué ahí? Nombre una consecuencia concreta de haberlo puesto en otra parte

Respuesta:
El estado de la pantalla está en `_EstadoTabla`, de forma específica en la variable `asistencias`. Es así porque `Tabla` es el widget que gestiona toda la lista de estudiantes: recibe la lista completa, luego construye cada fila, que es `LineaEstudiante`, y a la vez es el único punto con acceso a todos los estudiantes. Es justamente por eso que es el único lugar donde se calcula y se mantiene actualizado el total de asistencias. También existe el dato individual de cada estudiante, `estudiante.asistencia`, que técnicamente también es un estado, pero vive en el modelo `Estudiante` y no directamente en un `State` de Flutter.

Una consecuencia de poner el estado en otra parte, por ejemplo en `LineaEstudiante`, sería que el cambio de una asistencia cualquiera se reflejaría, sí, pero solo en esa fila; `Tabla` no tendría una fuente local clara para actualizar el contador general. Entonces, se tendrían que usar callbacks adicionales o administrar el estado desde un widget superior. Si esa comunicación no se implementara correctamente, el número de asistencias podría quedarse desactualizado aunque el botón de la fila mostrara el cambio.

## Reconstrucción de widgets

Pregunta textual
> ¿Qué se reconstruye cuando el usuario cambia un solo registro, y qué hizo, si hizo algo, para que no se reconstruya de más?

Respuesta:
Cuando un usuario cambia un registro, primero se reconstruye solo esa fila gracias a `setState` en `LineaEstudiante`. Luego, el callback dispara un segundo `setState` en `Tabla`, que reconstruye todo su `build()`. Sin embargo, Flutter no destruye ni recrea las filas existentes: conserva el `State` de cada `LineaEstudiante` ya montada, por lo que ninguna fila pierde su estado interno. Además, `ListView.builder` construye sus hijos bajo demanda, es decir, solo las filas visibles, no toda la lista de golpe. Aun así, cada una de esas filas visibles vuelve a ejecutar su `itemBuilder`, generando una nueva descripción de widget aunque solo una haya cambiado realmente. Se evitaron más reconstrucciones hacia arriba (subir el estado), como, por ejemplo, al nivel completo de toda la app. Esto habría hecho que se reconstruyera toda la interfaz en lugar de solo la pantalla.

## Extracción de componente

Pregunta textual
> ¿Qué componente extrajo, con qué criterio, y qué habría pasado si hubiera usado un método en lugar de una clase?

Respuesta:
Se extrajo `LineaEstudiante` porque cada registro tiene una responsabilidad específica y propia, como mostrar los datos del estudiante y permitir cambiar de "asiste" a "no asiste", visto como ícono. El criterio fue separar la representación y el comportamiento repetido de cada fila del componente `Tabla`, que gestiona la lista y el contador.

Si se hubiera utilizado, por ejemplo, un método en lugar de una clase, siempre se podría ver la fila, pero esta no tendría su propio ciclo de vida ni un estado independiente para llamar a `setState`. Por esto, el cambio tendría que manejarse desde `Tabla`, y esto traería como consecuencia la aparición de más reconstrucciones y una mezcla de responsabilidades.

## Resultados de `flutter analyze`

```bash
flutter analyze
PS ~\controlador_de_asistencia> flutter analyze
Analyzing controlador_de_asistencia...                                  
No issues found! (ran in 2.9s)
```

## Declaración de uso de inteligencia artificial

Durante esta sesión, se consultó a la inteligencia artificial `Claude` únicamente para resolver dudas de sintaxis puntuales sobre los widgets `Row`, `Expanded` y `Column`.