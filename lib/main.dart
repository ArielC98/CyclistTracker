import 'package:flutter/material.dart';

//Importaciones de Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Paginas
import 'pages/home_page.dart';
import 'package:cyclist_tracker/pages/login_page.dart';
import 'package:cyclist_tracker/pages/create_user_page.dart';
import 'package:cyclist_tracker/pages/update_user_page.dart';
import 'package:cyclist_tracker/pages/settings_page.dart';

//Libreria global
import 'globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyclist Tracker',
      initialRoute: '/',
      routes: {
        '/': ((context) => globals.loggedIn ? const Home() : const LoginPage()),
        '/login': ((context) => const LoginPage()),
        '/create': ((context) => const CreateUserPage()),
        '/update': ((context) => const UpdateUserPage()),
        '/settings': ((context) => const SettingsPage()),
      },
    );
  }
}
