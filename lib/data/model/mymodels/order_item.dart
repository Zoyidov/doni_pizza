import 'package:pizza/data/model/mymodels/food_model.dart';

class OrderItem {
  final FoodItem food;
  final int quantity;

  OrderItem({
    required this.food,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      food: FoodItem.fromJson(json['food']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food': food.toJson(),
      'quantity': quantity,
    };
  }

  OrderItem copyWith({
    FoodItem? food,
    int? quantity,
  }) {
    return OrderItem(
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
    );
  }
}
