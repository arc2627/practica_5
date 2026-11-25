import 'package:flutter/material.dart';
import 'package:paisesgui/data/repositories/paises_repository.dart';
import 'package:paisesgui/domain/entities/pais.dart';
import 'package:paisesgui/ui/screens/infopais_general.dart';

class PaisesScreen extends StatelessWidget {
  // Referencia al repositorio, de donde obtendremos la lista de continentes
  final PaisesRepository _repository = PaisesRepository();
  final String continente;

  PaisesScreen({required this.continente, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Países de $continente",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Center(
        // Proporciona a _creaLlistaPaises la lista de paises de Europa
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: _creaListaPaises(_repository.getPaises(continente)),
        ),
      ),
    );
  }

  Widget _creaListaPaises(List<Pais> paises) {
    // Recibimos la lista de paises

    return ListView.builder(
      itemCount: paises.length,
      itemBuilder: (BuildContext context, int index) {
        return PaisCard(
          imagen: paises[index].imagen ?? '',
          nombre: paises[index].nombre,
        );
      },
    );
  }
}

class PaisCard extends StatelessWidget {
  // Este widget recibirá dos argumentos con nombre para construirse:
  // la imagen (imagen) y el nombre del país (nombre)
  const PaisCard({super.key, required this.imagen, required this.nombre});

  final String imagen;
  final String nombre;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                InfoPaisGeneral(nombrePais: nombre),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(image: NetworkImage(imagen)),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 40,
            child: Text(
              nombre,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
