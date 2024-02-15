import 'package:flutter/material.dart';
import 'package:ice_cream/_components/cart_item.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            const Text(
              'My Cart',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: const Color.fromARGB(255, 38, 39, 39)),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: cart.getUserCart().isEmpty
                  ? const Center(
                      child: Text(
                        'Your cart is empty.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cart.getUserCart().length,
                      itemBuilder: (context, index) {
                        // Get individual cart item
                        CartItem cartItem = cart.getUserCart()[index];
                        return Card(
                          elevation: 1,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: CartItemWidget(cartItem: cartItem),
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
