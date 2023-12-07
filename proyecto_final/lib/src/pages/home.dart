import 'package:flutter/material.dart';
import 'package:proyecto_final/src/models/peliculas.dart';
import 'package:proyecto_final/src/pages/detalle.dart';
import 'package:proyecto_final/src/providers/creditos.dart';
import 'package:proyecto_final/src/providers/peliculas.dart';
import 'package:intl/intl.dart';//libreria para darle formato especial a la fecha
import 'package:shared_preferences/shared_preferences.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _provider = PeliculasProvider();
  List<Pelicula> peliculas = [];
  bool isLoading = false;
  bool hasMore = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _loadPeliculas();
  }

  Future<void> _loadPeliculas() async {
    if (isLoading || !hasMore) {
      return;
    }

    try {
      setState(() {
        isLoading = true;
        isError = false;
      });

      final nextResults = await _provider.getPeliculas();
      setState(() {
        peliculas.addAll(nextResults);
        hasMore = nextResults.isNotEmpty; // Verifica si hay más resultados
      });
    } catch (error) {
      //print('Error al cargar películas: $error');
      setState(() {
        isError = true; // Establece el estado de error
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Función para determinar si se ha alcanzado el final de la lista
  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
        _loadPeliculas();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 37, 65),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Borrar preferencias de usuario (token)
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('token');

              // Navegar de regreso a la pantalla de inicio de sesión
              Navigator.pop(context);
            },
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

      ///Drawer********************************************
      drawer: Drawer(
        backgroundColor: Colors.white.withAlpha(240),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 3, 37, 65),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Color.fromARGB(255, 3, 37, 65),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Usuario',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_rounded),
              title: const Text('Tu cuenta'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoritas'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: const Text('Agregadas recientemente'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificaciones'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuracion'),
              onTap: () {},
            ),
          ],
        ),
      ),

      ///Body********************************************
      body: isError
          ? ErrorWidget(
              message: 'Error de conexion',
              onRetry: _loadPeliculas,
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(13.0),
                    color: const Color.fromARGB(255, 4, 56, 88),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bienvenidos.',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Millones de peliculas, y personas por descubrir.Explora ahora.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Buscar películas...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 15, 196, 199)),
                              child: const Text(
                                'Buscar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Explora nuestras peliculas mas populares:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // ListView.builder con las películas
                  NotificationListener<ScrollNotification>(
                    onNotification: _onNotification,
                    child: SizedBox(
                      height: 420,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: peliculas.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < peliculas.length) {
                            return ItemPeliculas(peliculas: peliculas[index]);
                          } else {
                            return _buildLoader();
                          }
                        },
                      ),
                    ),
                  ),
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

  Widget _buildLoader() {
    return isLoading
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container();
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error,
                size: 150, color: Color.fromARGB(255, 4, 56, 88)),
            Text(
              message,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 15, 196, 199),
                elevation: 20,
              ),
              child: const Text(
                'Reintentar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 37, 65),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemPeliculas extends StatelessWidget {
  const ItemPeliculas({
    Key? key,
    required this.peliculas,
  }) : super(key: key);

  final Pelicula peliculas;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(23.0),
      child: Card(
        elevation: 0,
        child: InkWell(
          onTap: () async {
            // Obtener los créditos antes de navegar a la página de detalles
            peliculas.creditos = await CastProvider('fc6fbb57a0da4c9e2b7f1c733509685a').getCreditos(peliculas);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetallePelicula(pelicula: peliculas),
              ),
            );
          },
          splashColor:
              const Color.fromARGB(78, 15, 196, 199), // Color del splash
          splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w185/${peliculas.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 175,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          peliculas.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _formatReleaseDate(peliculas.releaseDate),
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 98,
                left: 10,
                child: PorcentajeWidget(porcentaje: peliculas.voteAverage * 10),
              ),
              const Positioned(
                top: 10,
                right: 10,
                child: CirculoWidget(),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  //Funcion para darle formato a la fecha de estreno de las peliculas
  String _formatReleaseDate(DateTime releaseDate) {
    return DateFormat('dd MMM yyyy').format(releaseDate);
  }
}

class PorcentajeWidget extends StatelessWidget {
  final double porcentaje;

  const PorcentajeWidget({super.key, required this.porcentaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 15, 196, 199),
      ),
      child: Center(
        child: Text(
          '${porcentaje.toStringAsFixed(0)}%',
          style: const TextStyle(
            color: Color.fromARGB(255, 3, 37, 65),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CirculoWidget extends StatelessWidget {
  const CirculoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white54,
      ),
      child: InkWell(
        onTap: () {},
        child: const Center(
          child: Icon(
            size: 25,
            Icons.more_horiz_outlined,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
