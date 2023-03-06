import 'package:flutter/material.dart';

//Importaciones de Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Paginas
import 'pages/home_page.dart';
import 'package:cyclist_tracker/pages/create_user_page.dart';
import 'package:cyclist_tracker/pages/update_name_page.dart';

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
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': ((context) => const Home()),
        '/create': ((context) => const CreateNamePage()),
        '/update': ((context) => const UpdateNamePage()),
      },
    );
  }
}
