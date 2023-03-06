import 'package:cyclist_tracker/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateNamePage extends StatefulWidget {
  const CreateNamePage({super.key});

  @override
  State<CreateNamePage> createState() => _CreateNamePageState();
}

class _CreateNamePageState extends State<CreateNamePage> {
  TextEditingController userController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController nameController = TextEditingController(text: "");
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Ingrese el nombre del usuario',
            ),
          ),
          TextField(
            controller: userController,
            decoration: const InputDecoration(
              hintText: 'Ingrese el correo electrónico',
            ),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Ingrese la contraseña',
            ),
          ),
          CheckboxListTile(
            title: const Text("Usuario administrador"),
            checkColor: Colors.white,
            value: isChecked,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  await auth
                      .createUserWithEmailAndPassword(
                          email: userController.text,
                          password: passwordController.text)
                      .then((_) {
                    createUser(nameController.text, isChecked);
                    showAlertDialog(
                        context, "Éxito", "Usuario creado exitosamente");
                    nameController.text = "";
                    userController.text = "";
                    passwordController.text = "";
                  });
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'contraseña debil') {
                    showAlertDialog(
                        context, "Error", "La contraseña es muy debil");
                  } else if (e.code == 'email-already-in-use') {
                    showAlertDialog(context, "Error",
                        "El correo ingresado ya esta registrado");
                  }
                } catch (e) {
                  showAlertDialog(context, "Error", "Fallo en la conexión");
                  print(e);
                }
              },
              child: const Text('Crear'))
        ]),
      ),
    );
  }
}

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
