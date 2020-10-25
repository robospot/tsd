import 'dart:convert';

class Material {
  int id;
  String ean;
  String language;
  String description;
  String createdAt;
  String updatedAt;
  Material({
    this.id,
    this.ean,
    this.language,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Material copyWith({
    int id,
    String ean,
    String language,
    String description,
    String createdAt,
    String updatedAt,
  }) {
    return Material(
      id: id ?? this.id,
      ean: ean ?? this.ean,
      language: language ?? this.language,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ean': ean,
      'language': language,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Material.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Material(
      id: map['id'],
      ean: map['ean'],
      language: map['language'],
      description: map['description'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Material.fromJson(var source) => Material.fromMap(source);

  @override
  String toString() {
    return 'Material(id: $id, ean: $ean, language: $language, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Material &&
        o.id == id &&
        o.ean == ean &&
        o.language == language &&
        o.description == description &&
        o.createdAt == createdAt &&
        o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ean.hashCode ^
        language.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
