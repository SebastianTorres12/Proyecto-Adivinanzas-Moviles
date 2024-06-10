import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adivinanzas para niños')),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/background_image.jpg', // Ruta a tu imagen de fondo
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text(
                'Empezar a Jugar',
                style: TextStyle(
                  fontSize: 24, // Tamaño del texto más grande
                  fontWeight: FontWeight.bold, // Texto en negrita
                  color: Colors.white, // Color del texto blanco
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/quiz');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepOrange, padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0), // Color del texto
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
                ),
                elevation: 10.0, // Sombra del botón
                shadowColor: Colors.black, // Color de la sombra
              ),
            ),
          ),
        ],
      ),
    );
  }
}
