import 'package:sqflite/sqflite.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final String category;
  final String imagePath;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imagePath': imagePath,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      description: map['description'],
      price: map['price'],
      category: map['category'],
      imagePath: map['imagePath'],
    );
  }
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
