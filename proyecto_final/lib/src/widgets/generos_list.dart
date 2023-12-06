import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/src/models/peliculas.dart';

class GeneroProvider {
  Future<Genre> getGenero(int genreId) async {
    final url = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/genre/movie/list',
        queryParameters: {
          'api_key': 'fc6fbb57a0da4c9e2b7f1c733509685a',
          'language': 'es-HN',
        });
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw (Exception('Error al cargar los generos'));
    }
    String body = res.body;
    final bodyJson = jsonDecode(body);

    if (bodyJson["genres"] == Null) {
      throw (Exception('No se encontraron géneros'));
    }

    final genero = bodyJson['genres'].firstWhere(
      (genero) => genero['id'] == genreId,
      orElse: () => null, // Si no encuentra un género, devuelve null
    );

    if (genero == null) {
      throw Exception('No se encontró el género');
    }

    final nGenero = Genre.fromJson(genero);
    return nGenero;
  }
}

class GenerosText extends StatelessWidget {
  final List<int> genreIds;

  const GenerosText({required this.genreIds});

  @override
  Widget build(BuildContext context) {
    final GeneroProvider provider =
        GeneroProvider(); // Instancia del GeneroProvider

    return FutureBuilder<List<Genre>>(
      future: _obtenerGeneros(
          provider), // Llamada a _obtenerGeneros con el provider
      builder: (BuildContext context, AsyncSnapshot<List<Genre>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Cargando...',
            style: TextStyle(fontSize: 12, color: Colors.white),
          );
        } else if (snapshot.hasError) {
          return const Text('Error al cargar los géneros');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No se encontraron géneros');
        } else {
          String generosText =
              snapshot.data!.map((genero) => genero.name).join(', ');
          return Text(
            generosText,
            style: const TextStyle(
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
          );
        }
      },
    );
  }

  Future<List<Genre>> _obtenerGeneros(GeneroProvider provider) async {
    List<Genre> generos = [];
    for (int genreId in genreIds) {
      Genre genero = await provider.getGenero(genreId);
      generos.add(genero);
    }
    return generos;
  }
}
