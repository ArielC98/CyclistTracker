library my_prj.globals;

import 'package:flutter/material.dart';

bool loggedIn = false;
String role = "admin";

//Cuadro de alertas
showAlertDialog(BuildContext context, String title, String message) {
  // Crear el boton
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Crear el cuadro
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // mostrar el dialogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
