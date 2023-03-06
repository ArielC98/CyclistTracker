import 'package:cyclist_tracker/services/firebase_service.dart';
import 'package:flutter/material.dart';

class UpdateNamePage extends StatefulWidget {
  const UpdateNamePage({super.key});

  @override
  State<UpdateNamePage> createState() => _UpdateNamePageState();
}

class _UpdateNamePageState extends State<UpdateNamePage> {
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['name'];
    return Scaffold(
      appBar: AppBar(title: const Text('Actualizar Nombre')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Ingrese la modificación',
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await updateUser(arguments['uid'], nameController.text)
                    .then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text('Actualizar'))
        ]),
      ),
    );
  }
}
