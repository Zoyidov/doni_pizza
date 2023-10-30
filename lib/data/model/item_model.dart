class MenuItem {
  final String name;
  final String description;
  final double price;
  final String category;
  final String imagePath;
  int count;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imagePath,
    this.count = 1,
  });
}