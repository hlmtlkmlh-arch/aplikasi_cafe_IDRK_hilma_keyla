import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu_items.dart';

class CartService {
  static final CartService instance = CartService._internal();
  CartService._internal();

  // Map<idMenu, qty>
  final Map<String, int> items = {};
  final Map<String, MenuModel> catalog = {};

  /// Tambah item ke cart
  void add(MenuModel item) {
    catalog[item.id] = item;  
    items[item.id] = (items[item.id] ?? 0) + 1;
  }

  /// Hitung total harga
  double total() {
    double sum = 0;
    items.forEach((id, qty) {
      final item = catalog[id];
      if (item != null) {
        sum += item.price * qty;
      }
    });
    return sum;
  }

  /// Checkout simpan ke Firestore
  Future<void> checkout(String userId) async {
    if (items.isEmpty) return;

    final orderItems = items.entries.map((e) {
      final item = catalog[e.key];
      return {
        "id": e.key,
        "name": item?.name ?? "-",
        "qty": e.value,
        "price": item?.price ?? 0,
      };
    }).toList();

    await FirebaseFirestore.instance.collection("orders").add({
      "userId": userId,
      "total": total(),
      "items": orderItems,
      "timestamp": FieldValue.serverTimestamp(),
    });

    items.clear();
    catalog.clear(); // supaya tidak nyangkut data lama
  }
}
