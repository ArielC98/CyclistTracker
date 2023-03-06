import 'package:cyclist_tracker/services/firebase_service.dart';
import 'package:flutter/material.dart';

class CreateNamePage extends StatefulWidget {
  const CreateNamePage({super.key});

  @override
  State<CreateNamePage> createState() => _CreateNamePageState();
}

class _CreateNamePageState extends State<CreateNamePage> {
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir Nombre')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Ingrese un nuevo nombre',
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await createUser(nameController.text).then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text('Guardar'))
        ]),
      ),
    );
  }
}
