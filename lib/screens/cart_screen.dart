import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/cart_service.dart';
import '../models/menu_items.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService cart = CartService.instance;

  @override
  Widget build(BuildContext context) {
    final items = cart.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),

      body: items.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : ListView(
              children: items.entries.map((e) {
                final id = e.key;
                final qty = e.value;

                final MenuModel? item = cart.catalog[id];

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/${item?.image}",
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 55,
                        height: 55,
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  title: Text(item?.name ?? 'Unknown'),
                  subtitle: Text('Qty: $qty'),
                  trailing: Text(
                    'Rp ${(item != null ? item.price * qty : 0).toStringAsFixed(0)}',
                  ),
                );
              }).toList(),
            ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: Rp ${cart.total().toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final userId = FirebaseAuth.instance.currentUser!.uid;

                  await CartService.instance.checkout(userId);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Checkout berhasil!")),
                  );

                  setState(() {}); // refresh UI
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Checkout gagal: $e")),
                  );
                }
              },
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}
