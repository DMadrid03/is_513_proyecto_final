
// To parse this JSON data, do
//
//     final listaPeliculas = listaPeliculasFromJson(jsonString);

import 'dart:convert';

Peliculas peliculasFromJson(String str) => Peliculas.fromJson(json.decode(str));

String peliculasToJson(Peliculas data) => json.encode(data.toJson());

class Peliculas {
  bool adult;
  String backdropPath;
  dynamic belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<dynamic> productionCompanies;
  List<ProductionCountry> productionCountries;
  DateTime releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Peliculas({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Peliculas.fromJson(Map<String, dynamic> json) {
    return Peliculas(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"] ?? "",
      belongsToCollection: json["belongs_to_collection"],
      budget: json["budget"] ?? 0,
      genres: (json["genres"] as List<dynamic>?)?.map((genre) => Genre.fromJson(genre)).toList() ?? [],
      homepage: json["homepage"] ?? "",
      id: json["id"] ?? 0,
      imdbId: json["imdb_id"] ?? "",
      originalLanguage: json["original_language"] ?? "",
      originalTitle: json["original_title"] ?? "",
      overview: json["overview"] ?? "",
      popularity: json["popularity"]?.toDouble() ?? 0.0,
      posterPath: json["poster_path"] ?? "",
      productionCompanies: (json["production_companies"] as List<dynamic>?) ?? [],
      productionCountries: (json["production_countries"] as List<dynamic>?)?.map((x) => ProductionCountry.fromJson(x)).toList() ?? [],
      releaseDate: DateTime.tryParse(json["release_date"] ?? "") ?? DateTime.now(),
      revenue: json["revenue"] ?? 0,
      runtime: json["runtime"] ?? 0,
      spokenLanguages: (json["spoken_languages"] as List<dynamic>?)?.map((x) => SpokenLanguage.fromJson(x)).toList() ?? [],
      status: json["status"] ?? "",
      tagline: json["tagline"] ?? "",
      title: json["title"] ?? "",
      video: json["video"] ?? false,
      voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
      voteCount: json["vote_count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "adult": adult,
      "backdrop_path": backdropPath,
      "belongs_to_collection": belongsToCollection,
      "budget": budget,
      "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      "homepage": homepage,
      "id": id,
      "imdb_id": imdbId,
      "original_language": originalLanguage,
      "original_title": originalTitle,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      "production_companies": List<dynamic>.from(productionCompanies.map((x) => x)),
      "production_countries": List<dynamic>.from(productionCountries.map((x) => x.toJson())),
      "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
      "revenue": revenue,
      "runtime": runtime,
      "spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
      "status": status,
      "tagline": tagline,
      "title": title,
      "video": video,
      "vote_average": voteAverage,
      "vote_count": voteCount,
    };
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

class ProductionCountry {
    String iso31661;
    String name;

    ProductionCountry({
        required this.iso31661,
        required this.name,
    });

    factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };
}

class SpokenLanguage {
    String englishName;
    String iso6391;
    String name;

    SpokenLanguage({
        required this.englishName,
        required this.iso6391,
        required this.name,
    });

    factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
    };
}
