import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hero_model.dart';

class ApiService {
  static const String url =
      'https://akabab.github.io/superhero-api/api/all.json';

  static Future<List<HeroModel>> fetchHeroes() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((hero) => HeroModel.fromJson(hero)).toList();
    } else {
      throw Exception('Erro ao carregar heróis');
    }
  }
}
