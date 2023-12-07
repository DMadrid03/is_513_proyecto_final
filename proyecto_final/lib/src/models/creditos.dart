// To parse this JSON data, do
//
//     final creditos = creditosFromJson(jsonString);

import 'dart:convert';

Creditos creditosFromJson(String str) => Creditos.fromJson(json.decode(str));

String creditosToJson(Creditos data) => json.encode(data.toJson());

class Creditos {
    int id;
    List<Cast> cast;
    List<Cast> crew;

    Creditos({
        required this.id,
        required this.cast,
        required this.crew,
    });

    factory Creditos.fromJson(Map<String, dynamic> json) => Creditos(
        id: json["id"]?? 0,
        cast: (json["cast"] as List<dynamic>?)?.map((x) => Cast.fromJson(x as Map<String, dynamic>)) .toList() ?? [],
        crew: (json["crew"] as List<dynamic>?)?.map((x) => Cast.fromJson(x as Map<String, dynamic>)).toList() ?? [],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    };
}

class Cast {
    bool adult;
    int gender;
    int id;
    Department knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String profilePath;
    int? castId;
    String? character;
    String creditId;
    int? order;
    Department? department;
    String? job;

    Cast({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        required this.profilePath,
        required this.castId,
        required this.character,
        required this.creditId,
        this.order,
        this.department,
        this.job,
    });

    factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"]?? false,
        gender: json["gender"]?? 0,
        id: json["id"]?? 0,
        knownForDepartment: departmentValues.map[json["known_for_department"]] ?? Department.ACTING,
        name: json["name"] ?? "",
        originalName: json["original_name"] ?? "",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        profilePath: json["profile_path"] ?? "",
        castId: json["cast_id"] ?? 0,
        character: json["character"] ?? "",
        creditId: json["credit_id"] ?? "",
        order: json["order"] ?? 0,
        department: departmentValues.map[json["department"]] ?? Department.ACTING,
        job: json["job"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": departmentValues.reverse[knownForDepartment],
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": departmentValues.reverse[department],
        "job": job,
    };
}

enum Department {
    ACTING,
    ART,
    CAMERA,
    CREW,
    DIRECTING,
    EDITING,
    LIGHTING,
    PRODUCTION,
    SOUND,
    VISUAL_EFFECTS,
    WRITING
}

final departmentValues = EnumValues({
    "Acting": Department.ACTING,
    "Art": Department.ART,
    "Camera": Department.CAMERA,
    "Crew": Department.CREW,
    "Directing": Department.DIRECTING,
    "Editing": Department.EDITING,
    "Lighting": Department.LIGHTING,
    "Production": Department.PRODUCTION,
    "Sound": Department.SOUND,
    "Visual Effects": Department.VISUAL_EFFECTS,
    "Writing": Department.WRITING
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