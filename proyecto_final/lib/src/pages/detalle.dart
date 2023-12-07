import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_final/src/models/creditos.dart';
import 'package:proyecto_final/src/models/peliculas.dart';
import 'package:proyecto_final/src/providers/peliculas.dart';
import 'package:proyecto_final/src/widgets/generos_list.dart';

class DetallePelicula extends StatelessWidget {
  final Pelicula pelicula;

  DetallePelicula({Key? key, required this.pelicula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 37, 65),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        title: const Center(
            child: Text(
          'THE MOVIE DB',
          style: TextStyle(
              color: Color.fromARGB(255, 15, 196, 199),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 3,
                ),
              ]),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                height: 800,
                color: const Color.fromARGB(255, 4, 56, 88),
              ),
              Positioned(
                child: Column(children: [
                  //Imagen de fondo de pelicula
                  Opacity(
                    opacity: 0.4,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original/${pelicula.backdropPath}',
                      fit: BoxFit.cover,
                      height: 210,
                      width: double.infinity,
                    ),
                  ),

                  //Texto y datos de la pelicula
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        //Titulo y año
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 250,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    pelicula.title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                '(${_formatReleaseDate1(pelicula.releaseDate)})',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        //Puntaje y Ver trailer
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 15, 196, 199),
                              ),
                              child: Center(
                                child: Text(
                                  '${(pelicula.voteAverage * 10).toStringAsFixed(0)}%',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 3, 37, 65),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 150,
                              ),
                              child: const Text(
                                'Puntuacion de usuario',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.play_arrow_rounded,
                                  size: 35,
                                  color: Color.fromARGB(255, 15, 196, 199),
                                ),
                                Text(
                                  'Ver trailer',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                      ],
                    ),
                  ),

                  //Fecha y generos
                  Container(
                    height: 65,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: Color.fromARGB(54, 255, 255, 255),
                            width: 1.0), // Línea de borde arriba
                        bottom: BorderSide(
                            color: Color.fromARGB(54, 255, 255, 255),
                            width: 1.0), // Línea de borde abajo
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                _formatReleaseDate2(pelicula.releaseDate),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16.5,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 250,
                                ),
                                child:
                                GenerosText(genreIds: pelicula.genreIds)
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Sinopsis y Director escritor
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Vista general',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: Text(
                            pelicula.overview,
                            maxLines: 8,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Director:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _getMemberName(
                                    pelicula.creditos.crew,
                                    Department.DIRECTING,
                                    'No disponible',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Escritor:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _getMemberName(
                                    pelicula.creditos.crew,
                                    Department.WRITING,
                                    'No disponible',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
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
            ]),

            // ACTORES************************************************
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reparto principal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // ignore: unrelated_type_equality_checks
                  if (pelicula.creditos != {})
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: pelicula.creditos.cast.length, 
                          itemBuilder: (context, index) {
                            Cast cast = pelicula.creditos.cast[index]; 
                            return Card(
                              child: ListTile(
                                title: Text(cast.name),
                                subtitle: Text(cast.character ?? 'Personaje desconocido'), 
                                // Otros detalles del crédito
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
            //-********************************************
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 3, 37, 65),
        selectedItemColor: const Color.fromARGB(255, 15, 196, 199),
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Peliculas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Series',
          ),
        ],
      ),
    );
  }

  String _formatReleaseDate1(DateTime releaseDate) {
    return DateFormat('yyyy').format(releaseDate);
  }

  String _formatReleaseDate2(DateTime releaseDate) {
    return DateFormat('dd/MM/yyyy').format(releaseDate);
  }
}

String _getMemberName(List<Cast>? crew, Department department, String defaultValue) {
  return crew
      ?.firstWhere(
        (crewMember) => crewMember.department == department,
        orElse: () => Cast(name: defaultValue, adult: false, gender: 0, id: 0, knownForDepartment: Department.CREW, originalName: '', popularity: 0.0, castId: 0, profilePath: "", character: "", creditId: "",),
      )
      .name ??
      defaultValue;
}
