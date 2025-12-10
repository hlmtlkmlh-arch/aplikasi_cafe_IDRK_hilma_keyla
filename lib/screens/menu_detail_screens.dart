// lib/screens/menu_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/menu_items.dart';
import '../services/cart_service.dart';
import '../services/firestore_service.dart';

class MenuDetailScreen extends StatefulWidget {
  final MenuModel? item;
  final String? itemId;

  MenuDetailScreen({
    this.item,
    this.itemId,
    super.key,
  }) : assert(item != null || itemId != null, 'item or itemId must be provided');

  @override
  State<MenuDetailScreen> createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  final FirestoreService _fs = FirestoreService();
  MenuModel? _item;
  bool _loading = false;
  bool _fetching = false;
  String? _error;

  final NumberFormat currency = NumberFormat('#,###', 'id_ID');

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _item = widget.item;
    } else {
      _fetchFromFirestore();
    }
  }

  Future<void> _fetchFromFirestore() async {
    if (widget.itemId == null) return;

    setState(() {
      _fetching = true;
      _error = null;
    });

    try {
      final fetched = await _fs.fetchMenuById(widget.itemId!);
      setState(() => _item = fetched);
    } catch (e) {
      setState(() => _error = 'Gagal mengambil data menu.\n${e.toString()}');
    } finally {
      setState(() => _fetching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Menu')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Menu')),
        body: Center(child: Text(_error!)),
      );
    }

    if (_item == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Menu')),
        body: const Center(child: Text('Menu tidak ditemukan')),
      );
    }

    final item = _item!;
    final String assetPath = "assets/images/${item.image}";

    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Image.asset(
                assetPath,
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 260,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported, size: 60),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 8),

                  Text(
                    "Rp ${currency.format(item.price)}",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.brown,
                        fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    item.description.isEmpty
                        ? 'Tidak ada deskripsi.'
                        : item.description,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _loading
                          ? null
                          : () async {
                              setState(() => _loading = true);

                              try {
                                CartService.instance.add(item);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          '${item.name} ditambahkan ke keranjang')),
                                );
                              } finally {
                                setState(() => _loading = false);
                              }
                            },
                      icon: _loading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.add_shopping_cart),
                      label: Text(
                          _loading ? 'Memproses...' : 'Tambah ke Keranjang'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
