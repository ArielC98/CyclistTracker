// Servicios
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../services/firebase_service.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  static const List<String> pages = <String>["/", "/create", "/settings"];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushNamed(context, pages[index]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
              title: const Text("Cyclist Tracker"),
              automaticallyImplyLeading: false),
          body: FutureBuilder(
          future: getUsers(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) async {
                      await deleteUser(snapshot.data?[index]['uid']);
                      snapshot.data?.removeAt(index);
                    },
                    confirmDismiss: (direction) async {
                      bool result = false;
                      result = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "¿Está seguro de querer eliminar a ${snapshot.data?[index]['name']}?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    return Navigator.pop(context, false);
                                  },
                                  child: const Text(
                                    "Cancelar",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    return Navigator.pop(context, true);
                                  },
                                  child: const Text("Confirmar"),
                                )
                              ],
                            );
                          });
                      return result;
                    },
                    background: Container(
                      color: Colors.red,
                      child: const Icon(Icons.delete),
                    ),
                    direction: DismissDirection.endToStart,
                    key: Key(snapshot.data?[index]['uid']),
                    child: ListTile(
                      title: Text((snapshot.data?[index]['name'])),
                      onTap: (() async {
                        await Navigator.pushNamed(context, "/update",
                            arguments: {
                              "name": snapshot.data?[index]['name'],
                              "uid": snapshot.data?[index]['uid'],
                            });
                        setState(() {});
                      }),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
          
          
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Agregar usuario',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Ajustes',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor:const Color.fromARGB(255, 0, 102, 255),
            onTap: _onItemTapped,
          ),
        ));
  }
}
