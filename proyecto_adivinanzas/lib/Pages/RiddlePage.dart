import 'dart:typed_data'; // Importar la biblioteca 'typed_data' para usar ByteData
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Model/Model_adivinanza.dart';
import 'dart:math';
import 'package:soundpool/soundpool.dart';
import 'FinalPage.dart'; // Importar FinalPage

class RiddlePage extends StatefulWidget {
  @override
  _RiddlePageState createState() => _RiddlePageState();
}

class _RiddlePageState extends State<RiddlePage> {
  Soundpool pool = Soundpool(streamType: StreamType.music);
  List<Adivinanza> adivinanzas = [];
  Adivinanza? adivinanzaActual;
  List<Map<String, String>> opcionesConImagenes = [];
  bool cargando = true;
  Random random = Random();
  int intentos = 0;
  int fallos = 0;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  @override
  void dispose() {
    pool.release(); // Liberar recursos al salir de la pantalla
    super.dispose();
  }

  Future<void> cargarDatos() async {
    adivinanzas = await cargarAdivinanzas();
    setState(() {
      cargarNuevaAdivinanza();
      cargando = false;
    });
  }

  void cargarNuevaAdivinanza() {
    if (adivinanzas.isEmpty) {
      return;
    }
    adivinanzaActual = adivinanzas.removeAt(random.nextInt(adivinanzas.length));
    opcionesConImagenes = List.generate(adivinanzaActual!.opciones.length, (index) {
      return {
        "opcion": adivinanzaActual!.opciones[index],
        "imagen": adivinanzaActual!.imagenes[index],
      };
    });
    opcionesConImagenes.shuffle();
  }

  void verificarRespuesta(String seleccion) {
    bool esCorrecta = seleccion == adivinanzaActual!.respuesta;
    if (!esCorrecta) {
      fallos++;
      reproducirSonidoIncorrecto();
    } else {
      reproducirSonidoCorrecto();
    }

    intentos++;

    if (intentos == 10) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FinalPage(fallos: fallos)),
      );
    } else {
      setState(() {
        cargarNuevaAdivinanza();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Adivinanzas para Niños'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Adivinanza ${intentos + 1} de 10'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/background_image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  adivinanzaActual!.pregunta,
                  style: TextStyle(fontFamily: 'Architec', fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 66.0,
                    crossAxisSpacing: 26.0,
                    children: opcionesConImagenes.map((opcionConImagen) {
                      return ElevatedButton(
                        onPressed: () => verificarRespuesta(opcionConImagen["opcion"]!),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.primaries[random.nextInt(Colors.primaries.length)], // Usar color aleatorio
                          textStyle: TextStyle(fontFamily: 'Architec', fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 70, // Aumentar el ancho
                              height: 70, // Aumentar la altura
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.asset(opcionConImagen["imagen"]!),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              opcionConImagen["opcion"]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> reproducirSonidoIncorrecto() async {
    int soundId = await rootBundle.load('assets/incorrect.mp3').then((ByteData soundData) {
      return pool.load(soundData);
    });
    await pool.play(soundId);
  }

  Future<void> reproducirSonidoCorrecto() async {
    int soundId = await rootBundle.load('assets/correct.mp3').then((ByteData soundData) {
      return pool.load(soundData);
    });
    await pool.play(soundId);
  }
}
