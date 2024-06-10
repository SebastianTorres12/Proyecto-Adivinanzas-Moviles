import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';
import 'Pages/RiddlePage.dart';


void main() {
  runApp(AdivinanzasApp());
}


class AdivinanzasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adivinanzas para Niños',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/quiz': (context) => RiddlePage(),
      },
    );
  }
}
