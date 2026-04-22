import 'package:flutter/material.dart';
import '../models/hero_model.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HeroModel> heroes = [];
  List<HeroModel> filteredHeroes = [];
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadHeroes();
  }

  Future<void> loadHeroes() async {
    try {
      final data = await ApiService.fetchHeroes();
      setState(() {
        heroes = data;
        filteredHeroes = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Erro ao carregar heróis: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterHeroes(String query) {
    final result = heroes.where((hero) {
      return hero.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredHeroes = result;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget buildHeroImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.image_not_supported,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text(
          'SuperHero Hub',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favoritos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.deepPurple,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  child: TextField(
                    controller: searchController,
                    onChanged: filterHeroes,
                    decoration: InputDecoration(
                      hintText: 'Pesquisar herói...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: filteredHeroes.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum herói encontrado.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: filteredHeroes.length,
                          itemBuilder: (context, index) {
                            final hero = filteredHeroes[index];

                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                leading: buildHeroImage(hero.imageUrl),
                                title: Text(
                                  hero.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    hero.publisher.isNotEmpty
                                        ? hero.publisher
                                        : 'Sem editora',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.deepPurple,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailScreen(hero: hero),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
