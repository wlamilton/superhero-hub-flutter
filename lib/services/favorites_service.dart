import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/hero_model.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _favorites =>
      _firestore.collection('favorites');

  Future<void> addFavorite(HeroModel hero) async {
    await _favorites.doc(hero.id.toString()).set(hero.toMap());
  }

  Future<void> removeFavorite(String id) async {
    await _favorites.doc(id).delete();
  }

  Stream<List<HeroModel>> getFavorites() {
    return _favorites.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return HeroModel.fromMap(doc.data());
      }).toList();
    });
  }
}
