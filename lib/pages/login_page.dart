import 'package:cyclist_tracker/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    FirebaseAuth auth = FirebaseAuth.instance;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
              title: const Text('Iniciar Sesión'),
              automaticallyImplyLeading: false),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
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
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await auth
                          .signInWithEmailAndPassword(
                              email: userController.text,
                              password: passwordController.text)
                          .then((_) {
                        globals.loggedIn = true;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'invalid-email') {
                        globals.showAlertDialog(
                            context, "Error", "Correo no válido");
                      } else if (e.code == 'wrong-password') {
                        globals.showAlertDialog(
                            context, "Error", "Contraseña incorrecta");
                      }
                    } catch (e) {
                      globals.showAlertDialog(
                          context, "Error", "Fallo en la conexión");
                      print(e);
                    }
                  },
                  child: const Text('Ingresar'))
            ]),
          ),
        ));
  }
}
