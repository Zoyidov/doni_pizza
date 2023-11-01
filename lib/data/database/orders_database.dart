// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/order_model.dart';

class OrderDatabase {
  static final OrderDatabase instance = OrderDatabase._privateConstructor();
  static Database? db;

  OrderDatabase._privateConstructor();

  Future<Database> get database async {
    if (db != null) return db!;
    db = await _initDatabase();
    return db!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'orders.db');
    return await openDatabase(dbPath, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            foodNames TEXT,
            totalCost REAL,
            timestamp TEXT
          )
        ''');
  }

  Future<void> insertOrder(OrderModel order) async {
    final db = await instance.database;
    await db.insert('orders', order.toMap());
  }

  Future<List<OrderModel>> getAllOrders() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('orders');
    return List.generate(maps.length, (index) {
      return OrderModel(
        foodNames: maps[index]['foodNames'],
        totalCost: maps[index]['totalCost'],
        timestamp: maps[index]['timestamp'],
      );
    });
  }

  Future<void> updateTotalCost(String description, double newTotalCost) async {
    final db = await instance.database;
    await db.update(
      'orders',
      {'totalCost': newTotalCost},
      where: 'foodNames = ?',
      whereArgs: [description],
    );
  }



  Future<void> deleteAllOrders() async {
    final db = await instance.database;
    await db.delete('orders');
  }

  Future<void> closeDatabase() async {
    final db = await instance.database;
    await db.close();
  }
}
