enum OrderStatus { pending, preparing, onRoute, delivered, canceled }

extension OrderStatusExtension on OrderStatus {
  String get stringValue {
    return toString().split('.').last;
  }

  static OrderStatus fromString(String status) {
    for (var value in OrderStatus.values) {
      if (value.stringValue == status) {
        return value;
      }
    }
    throw ArgumentError('Invalid OrderStatus string: $status');
  }
}
