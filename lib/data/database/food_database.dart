import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/food_model.dart';

class FoodDatabaseHelper {
  static final FoodDatabaseHelper instance = FoodDatabaseHelper._privateConstructor();
  static Database? _database;

  FoodDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'food_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS foods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        imagePath TEXT,
        price REAL,
        count INTEGER DEFAULT 1
      )
    ''');
  }

  Future<int> insertFood(FoodItem foodItem) async {
    final db = await database;

    final existingProducts = await db.query('foods', where: 'name = ?', whereArgs: [foodItem.name]);

    if (existingProducts.isNotEmpty) {
      final existingProduct = existingProducts.first;
      final existingCount = existingProduct['count'] as int?;
      final updatedCount = (existingCount ?? 0) + 1;
      await db.update(
        'foods',
        {'count': updatedCount},
        where: 'name = ?',
        whereArgs: [foodItem.name],
      );
    } else {
      await db.insert('foods', foodItem.toMap());
    }
    return 0;
  }



  Future<List<FoodItem>> fetchAllFoodItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('foods');
    return List.generate(maps.length, (index) {
      return FoodItem.fromMap(maps[index]);
    });
  }

  Future<void> updateFoodCount(int id, int count) async {
    final db = await database;
    await db.update(
      'foods',
      {'count': count},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteFood(int id) async {
    final db = await database;
    await db.delete(
      'foods',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.delete('foods');
  }
}
