class Pelicula{

  final int id;
  final String titulo;
  final String sinopsis;
  final String posterPath;
  final double rating;

  Pelicula({
    required this.id, 
    required this.titulo, 
    required this.sinopsis, 
    required this.posterPath,
    required this.rating
    });

    factory Pelicula.fromJson(Map<String, dynamic> json){
      return Pelicula(
        id: json['id'],
        titulo: json['titulo'],
        sinopsis: json['sinopsis'],
        posterPath: json['posterPath'],
        rating: json['rating']
      );
    }
}