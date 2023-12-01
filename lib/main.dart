// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   Future<void> _showMessage() async {
//     await Future.delayed(const Duration(seconds: 2));
//     print('Nach 2 Sekunden');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('future'),
//         backgroundColor: Colors.blueAccent, // Farbe der AppBar ändern
//       ),
//       body: Container(
//         color: const Color.fromARGB(255, 228, 245, 208), // Hellgrüne Hintergrundfarbe
//         child: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               _showMessage();
//             },
//             style: ElevatedButton.styleFrom(
//               primary: Colors.lightBlueAccent, // Hellblaue Farbe beim Klicken
//             ),
//             child: const Text(
//               'Meldung anzeigen',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   Future<List<String>> _getTexts() async {
//     await Future.delayed(Duration(seconds: 3));
//     return ['Text 1', 'Text 2', 'Text 3'];
//   }

//   Future<List<String>> _getImages() async {
//     await Future.delayed(Duration(seconds: 5));
//     return ['Image 1', 'Image 2', 'Image 3'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Aufgabe 2'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () async {
//                 List<String> texts = await _getTexts();
//                 print(texts);
//               },
//               child: Text('Texte laden'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 List<String> images = await _getImages();
//                 print(images);
//               },
//               child: Text('Bilder laden'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   Future<List<String>> _getImages() async {
//     await Future.delayed(Duration(seconds: 5));
//     return [
//       'https://hips.hearstapps.com/hmg-prod/images/close-up-of-purple-flowering-plants-royalty-free-image-1674159474.jpg?crop=1.00xw:0.752xh;0,0.248xh&resize=1200:*',
//       'https://hips.hearstapps.com/hmg-prod/images/close-up-of-purple-crocus-flowers-united-kingdom-uk-royalty-free-image-1674159456.jpg?crop=1xw:1xh;center,top&resize=980:*',
//       'https://hips.hearstapps.com/hmg-prod/images/close-up-of-purple-flowering-plants-royalty-free-image-1674159474.jpg?crop=1xw:1xh;center,top&resize=980:*',
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Aufgabe 3'),
//       ),
//       body: Center(
//         child: FutureBuilder<List<String>>(
//           future: _getImages(),
//           builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Fehler: ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   for (String imageUrl in snapshot.data!) Image.network(imageUrl),
//                 ],
//               );
//             } else {
//               return Text('Keine Daten');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class RandomUser {
  final String firstName;
  final String lastName;
  final String picture;

  RandomUser({required this.firstName, required this.lastName, required this.picture});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<RandomUser> _randomUserFuture;

  @override
  void initState() {
    super.initState();
    _randomUserFuture = fetchRandomUser();
  }

  Future<RandomUser> fetchRandomUser() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final user = data['results'][0];
      return RandomUser(
        firstName: user['name']['first'],
        lastName: user['name']['last'],
        picture: user['picture']['large'],
      );
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random User'),
      ),
      body: Center(
        child: FutureBuilder<RandomUser>(
          future: _randomUserFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.error, size: 50),
                  Text('Error loading user'),
                ],
              );
            } else if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data!.picture),
                    radius: 50,
                  ),
                  SizedBox(height: 20),
                  Text('${snapshot.data!.firstName} ${snapshot.data!.lastName}'),
                ],
              );
            } else {
              return Text('No data');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _randomUserFuture = fetchRandomUser();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
