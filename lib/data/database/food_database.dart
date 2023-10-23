import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/food_model.dart';

Future<Database> initDatabase() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'product_database.db');

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE products(
          name TEXT,
          description TEXT,
          price REAL,
          category TEXT,
          imagePath TEXT
        )
      ''');
    },
  );
}

class ProductDatabase {
  final Future<Database> database;

  ProductDatabase(this.database);

  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }
}
