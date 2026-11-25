import 'package:flutter/material.dart';
import 'package:paisesgui/data/repositories/paises_repository.dart';
import 'package:paisesgui/domain/entities/pais.dart';
import 'package:paisesgui/ui/screens/infopais_detalle.dart';

class InfoPaisGeneral extends StatelessWidget {
  final String nombrePais;
  // Referencia al repositorio, de donde obtendremos la lista de continentes
  final PaisesRepository _repository = PaisesRepository();
  InfoPaisGeneral({super.key, required this.nombrePais});

  @override
  Widget build(BuildContext context) {
    // Recogemos el país del repositorio
    Pais? pais = _repository.infoPais(nombrePais);

    // TO-DO
    // Añadir la información siguiente sobre el país:
    // Imagen, nombre, capital y descripción, de forma similar a como se muestra en el enunciado

    // Podéis utilizar los widgets y contenedores que consideréis oportunos (Containers, SingleChildScrollView, Columns, etc)
    // Debéis tener en cuenta no sobrepasar los límites y dibujar fuera del espacio disponible
    // Para comprobar que no os salís, podéis probar a girar el dispositivo (si lo estáis haciendo sobre Android)

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Información general",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      // Estructura de la pantalla Material Design
      body: Center(child: _creaPantallaPais(pais)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        onTap: (indice) {
          if (indice == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => InfoPaisDetalle(nombrePais: nombrePais),
              ),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'General',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Detalles',
          ),
        ],
      ),
    );
  }

  Widget _creaPantallaPais(Pais? pais) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        width: 500.0,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: NetworkImage(pais!.imagen!)),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pais.nombre,
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Capital: ${pais.capital}",
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                pais.descripcion ?? '',
                style: TextStyle(fontSize: 12.0),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
