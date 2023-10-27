import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/order_model.dart';

class OrderDatabase {
  late Database _database;

  OrderDatabase._privateConstructor();
  static final OrderDatabase instance = OrderDatabase._privateConstructor();

  Future<void> initDatabase() async {
    final path = join(await getDatabasesPath(), 'orders.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            foodNames TEXT,
            totalCost REAL,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertOrder(OrderModel order) async {
    await _database.insert('orders', order.toMap());
  }

  Future<List<OrderModel>> getAllOrders() async {
    final List<Map<String, dynamic>> maps = await _database.query('orders');
    return List.generate(maps.length, (index) {
      return OrderModel(
        foodNames: maps[index]['foodNames'],
        totalCost: maps[index]['totalCost'],
        timestamp: maps[index]['timestamp'],
      );
    });
  }

  Future<void> updateTotalCost(String description, double newTotalCost) async {
    await _database.update(
      'orders',
      {'totalCost': newTotalCost},
      where: 'foodNames = ?',
      whereArgs: [description],
    );
  }



  Future<void> deleteAllOrders() async {
    await _database.delete('orders');
  }

  Future<void> closeDatabase() async {
    await _database.close();
  }
}
