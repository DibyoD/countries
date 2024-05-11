class Country {
  final String name;
  final List<String> capitals;
  final int population;
  final String region;
  final String subregion;
  final String flagUrl;

  Country({
    required this.name,
    required this.capitals,
    required this.population,
    required this.region,
    required this.subregion,
    required this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? '',
      capitals: List<String>.from(json['capital'] ?? []),
      population: json['population'] ?? 0,
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      flagUrl: json['flags']['png'] ?? '',
    );
  }
}
