class FoodModel {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  int count;

  FoodModel({
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

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      name: map['name'],
      description: map['description'],
      imagePath: map['imagePath'],
      price: map['price'],
      count: map['count'],
    );
  }

  FoodModel copyWith({
    String? name,
    String? description,
    String? imagePath,
    double? price,
    int? count,
  }) {
    return FoodModel(
      name: name ?? this.name,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      count: count ?? this.count,
    );
  }
}
