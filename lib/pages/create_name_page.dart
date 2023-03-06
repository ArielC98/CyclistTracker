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
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir Usuario')),
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
                      .createUserWithEmailAndPassword(
                          email: userController.text,
                          password: passwordController.text)
                      .then((_) {
                    Navigator.pop(context);
                  });
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'contraseña debil') {
                    print('La contraseña es muy debil');
                  } else if (e.code == 'email-already-in-use') {
                    print('El correo ingresado ya esta registrado');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Crear'))
        ]),
      ),
    );
  }
}
