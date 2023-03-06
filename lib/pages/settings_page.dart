import 'package:cyclist_tracker/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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

  int _selectedIndex = 2;
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
              title: const Text('Ajustes'),
              automaticallyImplyLeading: false
            ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await auth.signOut().then((_) {
                        globals.loggedIn = false;
                        Navigator.pushNamed(context, '/');
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        globals.showAlertDialog(
                            context, "Error", "La contraseña es muy debil");
                      } else if (e.code == 'email-already-in-use') {
                        globals.showAlertDialog(context, "Error",
                            "El correo ingresado ya esta registrado");
                      }
                    } catch (e) {
                      globals.showAlertDialog(
                          context, "Error", "Fallo en la conexión");
                      print(e);
                    }
                  },
                  child: const Text('Cerrar sesión'))
            ]),
          ),
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
            selectedItemColor: Color.fromARGB(255, 0, 102, 255),
            onTap: _onItemTapped,
          ),
        ));
  }
}
