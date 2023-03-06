import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

//Funcion que lee los datos y los almacena en una lista
Future<List> getUsers() async {
  List users = [];
  CollectionReference collectionReferenceUsers =
      database.collection('usuarios');
  QuerySnapshot queryUsers = await collectionReferenceUsers.get();
  for (var document in queryUsers.docs) {
    final data = document.data() as Map<String, dynamic>;
    final user = {
      "name": data['name'],
      "uid": document.id,
    };
    users.add(user);
  }
  await Future.delayed(const Duration(seconds: 2)); //Muestra carga de datos
  return users;
}

//Guardar el nombre de un usuario en la base de datos
Future<void> createUser(String name) async {
  await database.collection("usuarios").add({"name": name});
}

//Actualizar el nombre de un usuario en la base de datos
Future<void> updateUser(String uid, String name) async {
  await database.collection("usuarios").doc(uid).set({"name": name});
}

//Borrar el nombre de un usuario en la base de datos
Future<void> deleteUser(String uid) async {
  await database.collection("usuarios").doc(uid).delete();
}
