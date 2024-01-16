import 'package:flutter/material.dart';

import 'ice.dart';

class Cart extends ChangeNotifier {
  // List of ice creams for sale
  List<Ice> iceShop = [
    Ice(
      name: 'Vanilla Pecan',
      price: '14',
      description:
          'A creamy vanilla base with pecan blondie pieces. The classic vanilla flavor pairs seamlessly with the sweet and nutty crunch of the blondie.',
      imagePath: 'lib/images/pot-4.webp',
    ),
    Ice(
      name: 'Chocolate Fudge ',
      price: '12',
      description:
          'A rich and indulgent dessert with a velvety chocolate base. This classic flavor delivers a satisfyingly smooth and decadent experience.',
      imagePath: 'lib/images/pot-2.webp',
    ),
    Ice(
      name: 'Caramel Brownie ',
      price: '15',
      description:
          'Blends silky caramel swirls with chewy brownie pieces, offering a delightful fusion of sweet and fudgy flavors in every bite.',
      imagePath: 'lib/images/pot-1.webp',
    ),
    Ice(
      name: 'Cookie Doe ',
      price: '11',
      description:
          'Cookie Dough ice cream combines creamy vanilla with sweet bites of raw cookie dough, creating a nostalgic and satisfying treat.',
      imagePath: 'lib/images/pot-3.webp',
    ),
  ];

  // List of items in the user's cart
  List<Ice> userCart = [];

  // Get list of ice creams for sale
  List<Ice> getIceList() {
    return iceShop;
  }

  // Get user's cart
  List<Ice> getUserCart() {
    return userCart;
  }

  // Add item to cart
  void addItemToCart(Ice ice) {
    userCart.add(ice);
    notifyListeners();
  }

  // Remove item from cart
  void removeItemFromCart(Ice ice) {
    userCart.remove(ice);
    notifyListeners();
  }
}
