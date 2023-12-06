import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/src/models/peliculas.dart';

class PeliculasProvider {
  int _currentPage = 1; //variable para manejar el conteo de la pagina actual
  bool _isLoading = false; //Indica el estado de carga de la pagina
  bool _hasMore = true; // Indica si hay más páginas disponibles
 

  Future<List<Pelicula>> getPeliculas() async {
    if (_isLoading || !_hasMore) {
      // Si ya se está cargando o no hay más páginas, no hace nada
      return [];
    }

    final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/popular',
      queryParameters: {
        'api_key': 'fc6fbb57a0da4c9e2b7f1c733509685a',
        'page': '$_currentPage',  //la pagina actual se le agrega a los parametros de consulta de la API
      },
    );

    try {
      _isLoading = true; // Establecer el estado de carga a true

      final res = await http.get(url);

      if (res.statusCode != 200) {
        //print('Código de estado de error: ${res.statusCode}'); //codigo innecesario, solo lo use para debugear
        throw Exception('Error al obtener las peliculas');
      }

      final String body = res.body;
      //print('Cuerpo de la respuesta: $body'); //codigo innecesario, solo lo use para debugear

      final bodyJson = json.decode(body);
      //print('Estructura de la respuesta: $bodyJson'); //codigo innecesario, solo lo use para debugear

      // Verificar si 'results' es nulo o no está presente en la respuesta
      if (bodyJson['results'] == null) {
        throw Exception('Error: No se encontró la lista de películas en la respuesta');
      }

      // Obteniendo la lista de películas desde la propiedad 'results'
      final List<dynamic> peliculasJson = bodyJson['results'];

      // Mapea la lista de películas utilizando la clase 'Result'
      final listaPeliculas = peliculasJson.map((pelicula) {
        return Pelicula.fromJson(pelicula);
      }).toList();

      // Actualizar el estado de la página actual y comprueba si hay mas páginas
      _currentPage++;
      _hasMore = bodyJson['page'] < bodyJson['total_pages'];

      return listaPeliculas;
    } catch (error) {
      //print('Error: $error'); //codigo innecesario, solo lo use para debugear
      throw Exception('Error al obtener la lista de peliculas');
    } finally {
      _isLoading = false; // Establecer el estado de carga a false al finalizar
    }
  }
}