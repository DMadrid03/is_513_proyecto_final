import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_final/src/models/peliculas.dart';


class DetallePelicula extends StatelessWidget {
  final Pelicula pelicula;

  const DetallePelicula({Key? key, required this.pelicula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 650,
                  color: const Color.fromARGB(255, 4, 56, 88),
                ),
                Positioned(
                  child: Column(
                    children: 
                    [ 
                      Opacity(
                        opacity: 0.4,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/original/${pelicula.backdropPath}',
                          fit: BoxFit.cover,
                          height: 210,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  pelicula.title,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, 
                                  ),
                                ),
                                const SizedBox(width:8), 
                                Text(
                                  '(${_formatReleaseDate(pelicula.releaseDate)})',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            const Row(
                              children: [
                                Text(
                                    'Puntuacion de usuario',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white, 
                                    ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]
                  ),
                ),
                Positioned(
                  top: 30, 
                  left: 18, 
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original/${pelicula.posterPath}',
                      fit: BoxFit.cover,
                      width: 100,
                      height: 150,
                    ),
                  ),
                ),
              ]
            ),


            //SOLO PARA RELLENAR POR MIENTRAS AQUI DEBERIAN IR LOS ACTORES 
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pelicula.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Color del texto
                    ),
                  ),
                
                ],
              ),
            ),
            //-**********************
          ],
        ),
      ),
    );
  }

  String _formatReleaseDate(DateTime releaseDate) {
    return DateFormat('yyyy').format(releaseDate);
  }
}