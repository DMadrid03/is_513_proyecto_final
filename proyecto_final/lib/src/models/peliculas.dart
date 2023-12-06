import 'dart:convert';

Populares peliculasFromJson(String str) => Populares.fromJson(json.decode(str));

String peliculasToJson(Populares data) => json.encode(data.toJson());

class Populares {
  int page;
  List<Pelicula> peliculas;
  int totalPages;
  int totalPeliculas;

  Populares({
    required this.page,
    required this.peliculas,
    required this.totalPages,
    required this.totalPeliculas,
  });

  factory Populares.fromJson(Map<String, dynamic> json) => Populares(
        page: json["page"],
        peliculas: List<Pelicula>.from(
            json["results"].map((x) => Pelicula.fromJson(x))),
        totalPages: json["total_pages"],
        totalPeliculas: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "peliculas": List<dynamic>.from(peliculas.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_peliculas": totalPeliculas,
      };
}

class Pelicula {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  OriginalLanguage originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Pelicula({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) {
    try {
      return Pelicula(
        adult: json["adult"] ?? false, // Valor predeterminado si es nulo
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"] ?? []),
        id: json["id"] ?? 0,
        originalLanguage:
            originalLanguageValues.map[json["original_language"]] ??
                OriginalLanguage.EN,
        originalTitle: json["original_title"] ?? "",
        overview: json["overview"] ?? "",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        posterPath: json["poster_path"] ?? "",
        releaseDate: DateTime.parse(json["release_date"] ?? "2000-01-01"),
        title: json["title"] ?? "",
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );
    } catch (e) {
      //print("Error al parsear la fecha: $e"); //codigo innecesario, solo lo use para debugear
      return Pelicula(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"] ?? []),
        id: json["id"] ?? 0,
        originalLanguage:
            originalLanguageValues.map[json["original_language"]] ??
                OriginalLanguage.EN,
        originalTitle: json["original_title"] ?? "",
        overview: json["overview"] ?? "",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        posterPath: json["poster_path"] ?? "",
        releaseDate: DateTime(2000, 1, 1),
        title: json["title"] ?? "",
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum OriginalLanguage { EN, HI, JA, MN }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "hi": OriginalLanguage.HI,
  "ja": OriginalLanguage.JA,
  "mn": OriginalLanguage.MN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
