import 'dart:convert';

class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final Map<String, int> stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.stats,
  });

  factory Pokemon.fromPokemonAndSpecies(
    Map<String, dynamic> pkmJson,
    Map<String, dynamic>? speciesJson,
  ) {
    final other = pkmJson['sprites']?['other'];
    final officialArtwork = other?['official-artwork']?['front_default'];
    final dreamWorld = other?['dream_world']?['front_default'];
    final frontDefault = pkmJson['sprites']?['front_default'];

    final img = officialArtwork ?? dreamWorld ?? frontDefault ?? '';

    final types =
        (pkmJson['types'] as List<dynamic>?)
            ?.map((t) => t['type']['name'] as String)
            .toList() ??
        const [];

    final abilities =
        (pkmJson['abilities'] as List<dynamic>?)
            ?.map((a) => a['ability']['name'] as String)
            .toList() ??
            const [];

    final stats = <String, int>{};
    for(final s in (pkmJson['stats']as List<dynamic>? ?? const [])) {
      final name = s['stat']['name'] as String;
      final value = (s['base_stat'] as num).toInt();
      stats[name] = value;
    }



    return Pokemon(
      id: pkmJson['id'] as int,
      name: pkmJson['name'] as String,
      imageUrl: img,
      types: types,
      abilities: abilities,
      stats: stats,
    );
  }
}
