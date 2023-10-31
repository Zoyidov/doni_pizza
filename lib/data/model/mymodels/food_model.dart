import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalPrice;
  final String status;
  final DateTime timestamp;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.timestamp,
  });

  factory OrderModel.fromJson(DocumentSnapshot documentReference) {
    final json = documentReference.data() as Map<String, dynamic>;
    final List<dynamic> itemsJson = json['items'];
    List<OrderItem> items = itemsJson.map((itemJson) => OrderItem.fromJson(itemJson)).toList();

    return OrderModel(
      id: documentReference.id,
      userId: json['userId'],
      items: items,
      totalPrice: json['totalPrice'].toDouble(),
      status: json['status'],
      timestamp: json['timestamp'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

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
}

class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory FoodItem.fromJson(DocumentSnapshot documentReference) {
    final json = documentReference.data() as Map<String, dynamic>;
    return FoodItem(
      id: documentReference.id,
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
