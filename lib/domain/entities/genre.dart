import 'dart:convert';

class GenreEntity {
  final int id;
  final String name;

  GenreEntity({
    required this.id,
    required this.name,
  });

  GenreEntity copyWith({
    int? id,
    String? name,
  }) =>
      GenreEntity(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory GenreEntity.fromJson(String str) =>
      GenreEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GenreEntity.fromMap(Map<String, dynamic> json) => GenreEntity(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
