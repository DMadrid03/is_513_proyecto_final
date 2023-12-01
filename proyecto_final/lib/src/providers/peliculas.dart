import 'dart:convert';
import 'package:proyecto_final/src/models/peliculas.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider{

  Future<List<Pelicula>> getPelicula() async{

    final res=await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=fc6fbb57a0da4c9e2b7f1c733509685a&query=movie_name'));

    if(res.statusCode==200)
    {
      final List<dynamic> peliculas = jsonDecode(res.body)['results'];

      return peliculas.map((json)=> Pelicula.fromJson(json)).toList();
    }
    else
    {
      throw Exception('Fallo al cargar peliculas');
    }
  }
}