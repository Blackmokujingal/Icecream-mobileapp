import 'package:flutter/material.dart';
import 'package:ice_cream/models/cart.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalPrice = cartItem.ice.price * cartItem.quantity;

    return Dismissible(
      key: Key(cartItem.ice.name),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Show confirmation dialog
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm", style: TextStyle(color: Colors.white)),
                content: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                    child: const Text(
                      "Are you sure you want to delete this item from your cart?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 38, 39, 39),
                contentPadding: const EdgeInsets.only(left: 72),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("DELETE", style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("CANCEL", style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          );
        }
        return false;
      },
      background: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Color.fromARGB(255, 215, 83, 73),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          Provider.of<Cart>(context, listen: false).removeItemFromCart(cartItem);
        }
      },

      
      dismissThresholds: const {DismissDirection.endToStart: 0.9},

      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 38, 39, 39),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 26, 25, 25).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Image.asset(cartItem.ice.imagePath),
          title: Text(
            cartItem.ice.name,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '\$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (cartItem.quantity > 1) {
                    Provider.of<Cart>(context, listen: false).decrementItemQuantity(cartItem);
                  }
                },
              ),
              Text(
                '${cartItem.quantity}',
                style: const TextStyle(color: Colors.white),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Provider.of<Cart>(context, listen: false).addItemToCart(cartItem.ice);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
