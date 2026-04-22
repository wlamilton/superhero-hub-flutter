import 'package:cloud_firestore/cloud_firestore.dart';

class TestFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveTestHero() async {
    await _firestore.collection('favorites').add({
      'name': 'Batman',
      'publisher': 'DC Comics',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
