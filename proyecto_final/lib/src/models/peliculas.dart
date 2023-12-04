import 'dart:convert';

Peliculas peliculasFromJson(String str) => Peliculas.fromJson(json.decode(str));

String peliculasToJson(Peliculas data) => json.encode(data.toJson());

class Peliculas {
    int page;
    List<Result> results;
    int totalPages;
    int totalResults;

    Peliculas({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory Peliculas.fromJson(Map<String, dynamic> json) => Peliculas(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Result {
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

    Result({
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

    factory Result.fromJson(Map<String, dynamic> json) {
        try{
          return Result(
            adult: json["adult"] ?? false, // Valor predeterminado si es nulo
            backdropPath: json["backdrop_path"],
            genreIds: List<int>.from(json["genre_ids"] ?? []),
            id: json["id"] ?? 0, 
            originalLanguage: originalLanguageValues.map[json["original_language"]] ?? OriginalLanguage.EN,
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
        }catch(e){
          print("Error al parsear la fecha: $e"); //codigo innecesario, solo lo use para debugear
          return Result(
            adult: json["adult"] ?? false, 
            backdropPath: json["backdrop_path"],
            genreIds: List<int>.from(json["genre_ids"] ?? []),
            id: json["id"] ?? 0, 
            originalLanguage: originalLanguageValues.map[json["original_language"]] ?? OriginalLanguage.EN,
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
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

enum OriginalLanguage {
    EN,
    HI,
    JA,
    MN
}

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
