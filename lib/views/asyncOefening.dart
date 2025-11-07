import 'dart:convert';

import 'package:bag_of_holding/models/Pokemon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class asyncOefening extends StatefulWidget {
  @override
  State<asyncOefening> createState() => _asyncOefeningState();
}

class _asyncOefeningState extends State<asyncOefening> {
  int currentID = 1;
  Future<Pokemon>? _future;
  final _controler = TextEditingController();

  void initState() {
    super.initState();
    _future = _fetchPokemonWithStats(currentID);
  }

  void dispose() {
    _controler.dispose();
    super.dispose();
  }

  Future<Pokemon>? _fetchPokemonWithStats(dynamic idOrName) async {
    final pokemonUri = Uri.https('pokeapi.co', '/api/v2/pokemon/$idOrName');
    final pkmRes = await http.get(pokemonUri);
    if (pkmRes.statusCode != 200) {
      throw Exception('PokeAPI fout: HTTP ${pkmRes.statusCode}');
    }
    final pkmJson = jsonDecode(pkmRes.body) as Map<String, dynamic>;

    Map<String, dynamic>? statsJson;
    final statsUrl = pkmJson['species']?['url'] as String?;
    if (statsUrl != null && statsUrl.isNotEmpty) {
      final statsUri = Uri.parse(statsUrl);
      final statsRes = await http.get(statsUri);
      if (statsRes.statusCode == 200) {
        statsJson = jsonDecode(statsRes.body) as Map<String, dynamic>;
      }
    }
    return Pokemon.fromPokemonAndSpecies(pkmJson, statsJson);
  }

  void _next() {
    setState(() {
      currentID += 1;
      _future = _fetchPokemonWithStats(currentID);
      _controler.clear();
      FocusScope.of(context).unfocus();
    });
  }

  void _back() {
    setState(() {
      if (currentID != 1) currentID -= 1;
      _future = _fetchPokemonWithStats(currentID);
      _controler.clear();
      FocusScope.of(context).unfocus();
    });
  }

  void _search() {
    final raw = _controler.text.trim();
    if (raw.isEmpty) {
      //  leeg dus doe niks
      return;
    }
    // API verwacht alleen lowercase values
    final query = int.tryParse(raw) ?? raw.toLowerCase();
    setState(() {
      _future = _fetchPokemonWithStats(query);
    });
    // maak de controller leeg
    _controler.clear();

    _future!
        .then((p) {
          if (mounted) {
            setState(() => currentID = p.id);
          }
        })
        .catchError((_) {});
  }

  // ------------------------------UI----------------------------------------- \\
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Pokemon viewer!"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Divider(),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: 350,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _controler,
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      labelText: 'Zoek op naam of id (bv. belsprout of 69)',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _search(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FilledButton.icon(
                onPressed: _search,
                label: const Text('Zoek'),
                icon: const Icon(Icons.search),
              ),
              const SizedBox(width: 30),
            ],
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Er ging wat mis oepsiepoepsie: \n${snapshot.error}',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                _future = _fetchPokemonWithStats(currentID);
                              });
                            },
                            child: const Text('Probeer opnieuw'),
                          ),
                        ],
                      );
                    }
                    final p = snapshot.data!;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: BorderSide.strokeAlignCenter,
                      children: [
                        Text(
                          '#${p.id}  ${_capitize(p.name)}',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        if (p.imageUrl.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              p.imageUrl,
                              fit: BoxFit.contain,
                              height: 280,
                            ),
                          )
                        else
                          const Icon(Icons.image_not_supported, size: 120),
                        const SizedBox(height: 24),
                        Card(
                          elevation: 0,
                          color:
                              Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Characteristics',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8),
                                Text('Types: ${p.types.join(', ')}'),
                                Text('Abilities: ${p.abilities.join(', ')}'),
                                const SizedBox(height: 8),
                                Text(
                                  'stats',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                Table(

                                  columnWidths: const {
                                    0: IntrinsicColumnWidth(),
                                    1: FlexColumnWidth(),
                                  },
                                  children:
                                      p.stats.entries
                                          .map(
                                            (e) => TableRow(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 2,
                                                      ),
                                                  child: Text(
                                                    '${_capitize(e.key)}:',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.all(2),
                                                  child: Text('${e.value}'),
                                                )
                                              ],
                                            ),
                                          )
                                          .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton.icon(
                              onPressed: _back,
                              label: const Text('Terug'),
                              icon: const Icon(Icons.navigate_before),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: FilledButton.icon(
                                onPressed: _next,
                                label: const Text('Volgende'),
                                icon: const Icon(Icons.navigate_before),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _capitize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
