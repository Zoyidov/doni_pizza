class FoodItem {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  int count;

  FoodItem({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    this.count = 1 ,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'price': price,
      'count': count,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      name: map['name'],
      description: map['description'],
      imagePath: map['imagePath'],
      price: map['price'],
      count: map['count'],
    );
  }
}
