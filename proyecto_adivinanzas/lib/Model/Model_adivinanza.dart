import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Adivinanza {
  final String pregunta;
  final List<String> opciones;
  final String respuesta;
  final List<String> imagenes;

  Adivinanza({
    required this.pregunta,
    required this.opciones,
    required this.respuesta,
    required this.imagenes,
  });

  factory Adivinanza.fromJson(Map<String, dynamic> json) {
    return Adivinanza(
      pregunta: json['pregunta'],
      opciones: List<String>.from(json['opciones']),
      respuesta: json['respuesta'],
      imagenes: List<String>.from(json['imagenes']),
    );
  }
}


Future<List<Adivinanza>> cargarAdivinanzas() async {
  try {
    final String respuesta = await rootBundle.loadString('assets/adivinanzas.json');
    final List<dynamic> data = json.decode(respuesta);
    return data.map((json) => Adivinanza.fromJson(json)).toList();
  } catch (e) {
    print('Error al cargar el archivo JSON: $e');
    return [];
  }
}

