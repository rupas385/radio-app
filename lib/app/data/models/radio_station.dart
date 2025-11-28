import 'dart:convert';


class RadioStationModel  {
  final String id;
  final String name;
  final String streamUrl;
  final String? iconUrl;
  final String? genre;
  final String? country;
  final bool isFavorite;

  const RadioStationModel({
    required this.id,
    required this.name,
    required this.streamUrl,
    this.iconUrl,
    this.genre,
    this.country,
    this.isFavorite = false,
  });


  RadioStationModel copyWith({
    String? id,
    String? name,
    String? streamUrl,
    String? iconUrl,
    String? genre,
    String? country,
    bool? isFavorite,
  }) {
    return RadioStationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      streamUrl: streamUrl ?? this.streamUrl,
      iconUrl: iconUrl ?? this.iconUrl,
      genre: genre ?? this.genre,
      country: country ?? this.country,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stationuuid': id,
      'name': name,
      'url_resolved': streamUrl,
      'favicon': iconUrl,
      'tags': genre,
      'country': country,
      'isFavorite': isFavorite,
    };
  }

  factory RadioStationModel.fromMap(Map<String, dynamic> map) {
    return RadioStationModel(
      id: map['stationuuid'] ?? '',
      name: map['name'] ?? 'Unknown Station',
      streamUrl: map['url_resolved'] ?? '',
      iconUrl: (map['favicon'] != null && map['favicon'].toString().isNotEmpty)
          ? map['favicon']
          : null,
      genre: map['tags'],
      country: map['country'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RadioStationModel.fromJson(String source) =>
      RadioStationModel.fromMap(json.decode(source));

}