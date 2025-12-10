import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu_items.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference menuRef =
      FirebaseFirestore.instance.collection('menu_items');

  Stream<List<MenuModel>> streamMenuItems() {
  return menuRef.snapshots().map((snap) {
    return snap.docs.map((doc) {
      return MenuModel.fromJson(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    }).toList();
  });
}


  Future<MenuModel?> fetchMenuById(String id) async {
    final doc = await _db.collection('menu_items').doc(id).get();

    if (!doc.exists) return null;

    return MenuModel.fromJson(doc.data()!, doc.id);
  }
}
