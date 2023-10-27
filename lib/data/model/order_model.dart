class OrderModel {
  final String foodNames;
  final double totalCost;
  final String timestamp;

  OrderModel({
    required this.foodNames,
    required this.totalCost,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'foodNames': foodNames,
      'totalCost': totalCost,
      'timestamp': timestamp,
    };
  }
}
