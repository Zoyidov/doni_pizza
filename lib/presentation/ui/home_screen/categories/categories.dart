import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Categories extends StatefulWidget {
  final List<String> imagePaths;
  final List<String> categoryText;
  final Function(String) onSelectedCategory;

  Categories({
    Key? key,
    required this.imagePaths,
    required this.categoryText,
    required this.onSelectedCategory,
  }) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.imagePaths.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                widget.onSelectedCategory(widget.categoryText[index]);
              });
            },
            child: ZoomTapAnimation(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: isSelected ? Colors.black : const Color(0xFFDDD7D7),
                    ),
                    child: Image.asset(widget.imagePaths[index], height: 50, width: 75),
                  ),
                  Text(
                    widget.categoryText[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
