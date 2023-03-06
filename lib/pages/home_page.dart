// Servicios
import 'package:cyclist_tracker/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cyclist Tracker"),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.amber[600],
                width: 48.0,
                height: 48.0,
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Color.fromARGB(255, 0, 4, 255),
                width: 48.0,
                height: 48.0,
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Color.fromARGB(255, 0, 4, 255),
                width: 78.0,
                height: 48.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Text("Tap on this"),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/create');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
