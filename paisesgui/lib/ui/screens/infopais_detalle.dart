import 'package:flutter/material.dart';
import 'package:paisesgui/data/repositories/paises_repository.dart';
import 'package:paisesgui/domain/entities/pais.dart';
import 'package:paisesgui/ui/widgets/my_weather_info.dart';
import 'package:paisesgui/ui/screens/infopais_general.dart';

class InfoPaisDetalle extends StatelessWidget {
  // Referencia al repositorio, de donde obtendremos la lista de continentes
  final PaisesRepository _repository = PaisesRepository();
  final String nombrePais;
  InfoPaisDetalle({super.key, required this.nombrePais});

  @override
  Widget build(BuildContext context) {
    Pais? pais = _repository.infoPais(nombrePais);

    // TO-DO
    // Añadir la información siguiente sobre el país:
    // Población (num. de habitantes), latitud y longitud.
    // Podéis combinar Column y Row para mostrar la información tabulada

    // Antes de la información, deberemos mostrar la información sobre el tiempo en el país,
    // mediante el widtget personalizado MyWeatherInfo(), que se os proporciona ya implementado
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Información detallada",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: _creaPantallaPaisDetalle(pais!),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,

        onTap: (indice) {
          if (indice == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => InfoPaisGeneral(nombrePais: nombrePais),
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

  Widget _creaPantallaPaisDetalle(Pais pais) {
    return Column(
      children: [
        MyWeatherInfo(),
        Container(
          width: 300,
          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Población:'),
                    Text('Latitud:'),
                    Text('Longitud:'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pais.poblacion ?? ''),
                    Text('${pais.latitud}'),
                    Text('${pais.longitud}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
