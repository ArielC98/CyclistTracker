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
    getUsers().then((value) {
      
    });

    if (globals.role == "master" || globals.role == "admin") {
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
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  decoration: const BoxDecoration(
                                      color:
                                          Color.fromARGB(236, 255, 255, 255)),
                                  width: 100,
                                  child: Text(snapshot.data?[index]['name'],
                                      textAlign: TextAlign.left),
                                )),
                                const SizedBox(
                                  width: 10,
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 33, 243, 131),
                                      border: Border.all(),
                                    ),
                                    child:  ElevatedButton(
                                        onPressed: (() async{
                                          Navigator.pushNamed(context, "/map");
                                        }),
                                        child: Icon(Icons.add_location)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 40,
                                ),
                                Container(
                                  width: 50,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 255, 241, 47),
                                    border: Border.all(),
                                  ),
                                  child: ElevatedButton(
                                      onPressed: (() async {
                                        await Navigator.pushNamed(
                                            context, "/update",
                                            arguments: {
                                              "name": snapshot.data?[index]
                                                  ['name'],
                                              "uid": snapshot.data?[index]
                                                  ['uid'],
                                            });
                                        setState(() {});
                                      }),
                                      child: const Icon(Icons.edit)),
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 96, 81),
                                      border: Border.all(),
                                    ),
                                    child: ElevatedButton(
                                        onPressed: (() async {
                                          await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "¿Está seguro de querer eliminar a ${snapshot.data?[index]['name']}?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        return Navigator.pop(
                                                            context, false);
                                                      },
                                                      child: const Text(
                                                        "Cancelar",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        deleteUser(snapshot
                                                                .data?[index]
                                                            ['uid']);
                                                        snapshot.data
                                                            ?.removeAt(index);
                                                        return Navigator.pop(
                                                            context, true);
                                                      },
                                                      child: const Text(
                                                          "Confirmar"),
                                                    )
                                                  ],
                                                );
                                              });
                                        }),
                                        child: const Icon(Icons.delete)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ));
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
              selectedItemColor: const Color.fromARGB(255, 0, 102, 255),
              onTap: _onItemTapped,
            ),
          ));
    } else {
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
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  decoration: const BoxDecoration(
                                      color:
                                          Color.fromARGB(236, 255, 255, 255)),
                                  width: 100,
                                  child: Text(snapshot.data?[index]['name'],
                                      textAlign: TextAlign.left),
                                )),
                                const SizedBox(
                                  width: 10,
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 33, 243, 131),
                                      border: Border.all(),
                                    ),
                                    child: const ElevatedButton(
                                        onPressed: null,
                                        child: Icon(Icons.add_location)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 40,
                                ),
                              ],
                            );
                          },
                        ));
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
              selectedItemColor: const Color.fromARGB(255, 0, 102, 255),
              onTap: _onItemTapped,
            ),
          ));
    }
  }
}
