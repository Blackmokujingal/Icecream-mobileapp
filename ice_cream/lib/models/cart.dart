import 'package:flutter/material.dart';
import 'ice.dart';

class Cart extends ChangeNotifier {
  // List of ice creams for sale
   List<Ice> iceShop = [
    Ice(
      name: 'Vanilla Pecan',
      price: 14.0, 
      description:
          'A creamy vanilla base with pecan blondie pieces. The classic vanilla flavor pairs seamlessly with the sweet and nutty crunch of the blondie.',
      imagePath: 'lib/images/pot-4.webp',
      type: IceType.cone,
    ),
    Ice(
      name: 'Chocolate Fudge ',
      price: 12.0, 
      description:
          'A rich and indulgent dessert with a velvety chocolate base. This classic flavor delivers a satisfyingly smooth and decadent experience.',
      imagePath: 'lib/images/pot-2.webp',
      type: IceType.pot,
    ),
    Ice(
      name: 'Caramel Brownie ',
      price: 15.0, 
      description:
          'Blends silky caramel swirls with chewy brownie pieces, offering a delightful fusion of sweet and fudgy flavors in every bite.',
      imagePath: 'lib/images/pot-1.webp',
      type: IceType.pot,
    ),
    Ice(
      name: 'Cookie Doe ',
      price: 11.0,
      description:
          'Cookie Dough ice cream combines creamy vanilla with sweet bites of raw cookie dough, creating a nostalgic and satisfying treat.',
      imagePath: 'lib/images/pot-3.webp',
      type: IceType.stick,
    ),
  ];

  // List of items in the user's cart
  List<CartItem> userCart = [];

  // Get list of ice creams for sale
  List<Ice> getIceList() {
    return iceShop;
  }

  // Get user's cart
  List<CartItem> getUserCart() {
    return userCart;
  }

  // Add item to cart
  void addItemToCart(Ice ice) {
    // Check if the item is already in the cart
    int index = userCart.indexWhere((item) => item.ice.name == ice.name);
    if (index != -1) {
      // If item is already in the cart, increment its quantity
      userCart[index].quantity++;
    } else {
      // If item is not in the cart, add it with quantity 1
      userCart.add(CartItem(ice: ice, quantity: 1));
    }
    notifyListeners();
  }

  // Remove item from cart
  void removeItemFromCart(CartItem cartItem) {
    userCart.removeWhere((item) => item.ice.name == cartItem.ice.name);
    notifyListeners();
  }

  // Decrement item quantity in cart
  void decrementItemQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
      notifyListeners();
    }
  }
}

class CartItem {
  final Ice ice;
  int quantity;

  CartItem({required this.ice, required this.quantity});
}
