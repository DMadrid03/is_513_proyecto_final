import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/src/models/peliculas.dart';

class PeliculasProvider {
  Future<List<Peliculas>> getPeliculas() async {

     final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/popular',
      queryParameters: {
        'api_key': 'fc6fbb57a0da4c9e2b7f1c733509685a',
      },
      
    );
    try {
      final res = await http.get(url);

      if (res.statusCode != 200) {
        print('Código de estado de error: ${res.statusCode}');
        throw Exception('Error al obtener las peliculas');
      }

      final String body = res.body; // String
      print('Cuerpo de la respuesta: $body');

      final bodyJson = json.decode(body);
      
      // Obteniendo la lista de películas desde la propiedad 'results'
      final List<dynamic> peliculasJson = bodyJson['results'];

      // Mapea la lista de películas
      final listaPeliculas = peliculasJson.map((pelicula) {
        return Peliculas.fromJson(pelicula);
      }).toList();
      //recorro el json y transformo cada elemento en una "Pelicula"

      return listaPeliculas;
    } catch (error) {
      print('Error: $error');
      throw Exception('Error al obtener la lista de peliculas');
    }

  }
}