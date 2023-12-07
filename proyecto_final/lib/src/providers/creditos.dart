import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/src/models/creditos.dart';
import 'package:proyecto_final/src/models/peliculas.dart';

class CastProvider {
   String apiKey = 'fc6fbb57a0da4c9e2b7f1c733509685a';
   CastProvider(this.apiKey);
   
  Future<Creditos> getCreditos(Pelicula pelicula) async {
    final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/${pelicula.id}/credits',
      queryParameters: {
        'api_key':  apiKey,
      }
    );

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(res.body);
        // Verificar si jsonData es nulo antes de usarlo
        return Creditos.fromJson(jsonData);
      } else {
        throw Exception('Error al cargar los creditos');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}