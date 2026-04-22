class HeroModel {
  final int id;
  final String name;
  final String imageUrl;
  final String fullName;
  final String publisher;
  final String alignment;
  final Map<String, dynamic> powerstats;

  HeroModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.fullName,
    required this.publisher,
    required this.alignment,
    required this.powerstats,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: json['images']?['md'] ?? '',
      fullName: json['biography']?['fullName'] ?? '',
      publisher: json['biography']?['publisher'] ?? '',
      alignment: json['biography']?['alignment'] ?? '',
      powerstats: Map<String, dynamic>.from(json['powerstats'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'fullName': fullName,
      'publisher': publisher,
      'alignment': alignment,
      'powerstats': powerstats,
    };
  }

  factory HeroModel.fromMap(Map<String, dynamic> map) {
    return HeroModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      fullName: map['fullName'] ?? '',
      publisher: map['publisher'] ?? '',
      alignment: map['alignment'] ?? '',
      powerstats: Map<String, dynamic>.from(map['powerstats'] ?? {}),
    );
  }
}
