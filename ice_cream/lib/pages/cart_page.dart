import 'package:flutter/material.dart';
import 'package:ice_cream/_components/cart_item.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/ice.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            const Text(
              'My Cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),

            const SizedBox(height: 20), // Increased spacing

            Expanded(
              child: value.getUserCart().isEmpty
                  ? const Center(
                      child: Text(
                        'Your cart is empty.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: value.getUserCart().length,
                      itemBuilder: (context, index) {
                        // Get individual ice
                        Ice individualIce = value.getUserCart()[index];

                        // Return the modernized cart item
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: CartItem(ice: individualIce),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
