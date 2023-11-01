import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza/data/model/mymodels/category_model.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _categoriesCollection = 'categories';

  /// Retrieves a list of all categories from the Firestore collection.
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final querySnapshot = await _firestore.collection(_categoriesCollection).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          return CategoryModel.fromJson(doc);
        }).toList();
      } else {
        throw Exception('No categories found.');
      }
    } catch (e) {
      throw Exception('Error fetching all categories: $e');
    }
  }

  /// Adds a new category to the Firestore collection.
  Future<void> addCategory(CategoryModel category) async {
    try {
      await _firestore.collection(_categoriesCollection).add(category.toJson());
    } catch (e) {
      throw Exception('Error adding category: $e');
    }
  }

  /// Updates an existing category in the Firestore collection.
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _firestore.collection(_categoriesCollection).doc(category.id).update(category.toJson());
    } catch (e) {
      throw Exception('Error updating category: $e');
    }
  }

  /// Deletes a specific category from the Firestore collection using its unique [categoryId].
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _firestore.collection(_categoriesCollection).doc(categoryId).delete();
    } catch (e) {
      throw Exception('Error deleting category: $e');
    }
  }
}
