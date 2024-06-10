import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importar para el sonido
import 'package:soundpool/soundpool.dart'; // Importar Soundpool
import 'RiddlePage.dart';

class FinalPage extends StatefulWidget {
  final int fallos;

  FinalPage({required this.fallos});

  @override
  _FinalPageState createState() => _FinalPageState();
}

  class _FinalPageState extends State<FinalPage> {
  Soundpool pool = Soundpool(streamType: StreamType.music);

  @override
  void initState() {
    super.initState();
    reproducirSonidoFinal();
  }

  @override
  void dispose() {
    pool.release(); // Liberar recursos al salir de la pantalla
    super.dispose();
  }

  Future<void> reproducirSonidoFinal() async {
    int soundId = await rootBundle.load('assets/final.mp3').then((ByteData soundData) {
      return pool.load(soundData);
    });
    await pool.play(soundId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultados"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/final_image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8), // Caja de color con opacidad
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Juego Terminado",
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Has tenido ${widget.fallos} fallos en 10 adivinanzas.",
                      style: TextStyle(fontSize: 20.0,),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    TextButton(
                      child: Text("Reiniciar",style: TextStyle(fontSize: 20),),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => RiddlePage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
