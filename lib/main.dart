import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<void> _showMessage() async {
    await Future.delayed(const Duration(seconds: 2));
    print('Nach 2 Sekunden');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('future'),
        backgroundColor: Colors.blueAccent, // Farbe der AppBar ändern
      ),
      body: Container(
        color: const Color.fromARGB(255, 228, 245, 208), // Hellgrüne Hintergrundfarbe
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              _showMessage();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlueAccent, // Hellblaue Farbe beim Klicken
            ),
            child: const Text(
              'Meldung anzeigen',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
