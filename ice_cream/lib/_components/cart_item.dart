import 'package:flutter/material.dart';
import 'package:ice_cream/models/ice.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class CartItem extends StatefulWidget {
  final Ice ice;

  const CartItem({Key? key, required this.ice}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  // Remove item from the cart
  void removeItemFromCart() {
    Provider.of<Cart>(context, listen: false).removeItemFromCart(widget.ice);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Image.asset(widget.ice.imagePath),
        title: Text(widget.ice.name),
        subtitle: Text('\$${widget.ice.price}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: removeItemFromCart,
        ),
      ),
    );
  }
}
