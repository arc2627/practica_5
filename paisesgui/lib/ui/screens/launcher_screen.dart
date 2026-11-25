import 'package:flutter/material.dart';
import 'package:paisesgui/ui/screens/continentes_screen.dart';

//import 'package:paisesgui/ui/screens/paises_screen.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Expanded(child: MyRegisterForm())],
      ),
    );
  }
}

// Creamos un widget con estado
class MyRegisterForm extends StatefulWidget {
  const MyRegisterForm({super.key});

  @override
  MyRegisterFormState createState() {
    return MyRegisterFormState();
  }
}

// Creamos una clase de tipo State
class MyRegisterFormState extends State<MyRegisterForm> {
  // Para esta clase vamos a crear una clve global, de tipo
  // FormState que nos sirva para identificar el widget en
  // el árbolo de widgets y por tanto poder validar el formulario.

  final String correoCorrecto = "aaaaa@aaa.aa";
  final String passCorrecta = "12345678";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controladorCorreo = TextEditingController();
  final TextEditingController _controladorPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Form(
          // Añadimos como clave del formulario la clave _formKey que hemos generado
          key: _formKey,
          // Organizamos los diferentes widgets del formulario en un ListView
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              // Para crear los distintos widgets hemos creado los tres métodos siguientes
              // de manera que aligeremos el código del método build:
              createRegisterNameFormField(),
              SizedBox(height: 20),
              createPasswordFormField(),
              SizedBox(height: 20),
              createSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Inicializamos el texto del controlador
    _controladorCorreo.text = "";
    _controladorPass.text = "";
  }

  @override
  void dispose() {
    // Liberamos el controlador cuando el widget se elimine
    _controladorCorreo.dispose();
    _controladorPass.dispose();
    super.dispose();
  }

  TextFormField createRegisterNameFormField() {
    // Crea el widget de tipo TextFormField
    return TextFormField(
      // Definimos el controlador
      controller: _controladorCorreo,
      // Con la propiedad validator definimos las validaciones
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'El correo no puede estar vacío';
        }
        // Expresión regular para validar un correo electrónico
        final regexCorreu = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

        // Validación del correo con la expresión regular
        if (!regexCorreu.hasMatch(value ?? "")) {
          return 'La dirección de correo no es válida';
        }
        return null;
      },

      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        icon: const Icon(Icons.email),
        labelText: "Dirección de correo",
      ),
    );
  }

  TextFormField createPasswordFormField() {
    // Crea el widget de tipo TextFormField
    return TextFormField(
      // Definimos el controlador
      controller: _controladorPass,
      // Con la propiedad validator definimos las validaciones
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'La contraseña no puede estar vacía';
        }
        return null;
      },

      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        icon: const Icon(Icons.password),
        labelText: "Contraseña",
      ),
      obscureText: true,
      obscuringCharacter: "·",
    );
  }

  Widget createSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            if (_controladorCorreo.text == correoCorrecto &&
                _controladorPass.text == passCorrecta) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ContinentesScreen(),
                ),
              );
            } else {
              final resultado = await mostrarDialogoCredenciales();

              if (resultado == true) {
                setState(() {
                  _controladorCorreo.text = correoCorrecto;
                  _controladorPass.text = passCorrecta;
                });
              }
            }
          }
        },
        child: const Text('Inicia sesión'),
      ),
    );
  }

  Future<bool?> mostrarDialogoCredenciales() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text(
            "El correo electrónico o la contraseña no son correctos.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Volver"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Rellenar campos"),
            ),
          ],
        );
      },
    );
  }
}
