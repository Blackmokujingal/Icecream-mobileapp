enum IceType {
  cone,
  pot,
  stick,
}

class Ice {
  final String name;
  final double price;
  final String imagePath;
  final String description;
  final IceType type; 
  int quantity; 

  Ice({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
    required this.type, 
    this.quantity = 1, 
  });
}
