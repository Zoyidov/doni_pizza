import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza/data/bloc/state_bloc.dart';
import 'package:pizza/data/model/food_model.dart';
import 'package:pizza/presentation/ui/home_screen/promotions/promotions.dart';
import 'package:pizza/utils/icons.dart';
import 'package:pizza/widgets/global_textfield.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/model/item_model.dart';
import '../detail_screen/detail_screen.dart';
import 'categories/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<MenuItem> allMenuItems = [
    MenuItem(
      name: 'Donar',
      description: 'Donar',
      price: 4.99,
      category: 'Pizza',
      imagePath: 'assets/images/pizza.png',
      count: 1,
    ),
    MenuItem(
      name: 'Pepperoni',
      description: 'Pepperoni',
      price: 4.69,
      category: 'Pizza',
      imagePath: 'assets/images/pepperoni.png',
      count: 1,
    ),
    MenuItem(
      name: 'Pepperoni Cheese',
      description: 'Pepperoni Cheese',
      price: 4.44,
      category: 'Pizza',
      imagePath: 'assets/images/cheese_pepperoni.png',
      count: 1,
    ),
    MenuItem(
      name: 'MushroomPizza',
      description: 'Mushroom',
      price: 6.46,
      category: 'Pizza',
      imagePath: 'assets/images/mushroom.png',
      count: 1,
    ),
    MenuItem(
      name: 'Chicken',
      description: 'Grill',
      price: 6.699,
      category: 'Chicken',
      imagePath: 'assets/images/chicken.png',
      count: 1,
    ),
    MenuItem(
      name: 'KFC',
      description: 'KFC',
      price: 3.49,
      category: 'Chicken',
      imagePath: 'assets/images/kfc.png',
      count: 1,
    ),
    MenuItem(
      name: 'Burger',
      description: 'Cheeseburger',
      price: 3.99,
      category: 'Burger',
      imagePath: 'assets/images/burger.png',
      count: 1,
    ),
    MenuItem(
      name: 'Beef Burger',
      description: 'Beef Burger',
      price: 2.49,
      category: 'Burger',
      imagePath: 'assets/images/beef_burger.png',
      count: 1,
    ),
    MenuItem(
      name: 'Classic Burger',
      description: 'Classic Burger',
      price: 2.55,
      category: 'Burger',
      imagePath: 'assets/images/classic_burger.png',
      count: 1,
    ),
    MenuItem(
      name: 'Cheese Burger',
      description: 'Cheese Burger',
      price: 3.5,
      category: 'Burger',
      imagePath: 'assets/images/cheese_burger.png',
      count: 1,
    ),
    MenuItem(
      name: 'Cobb Salad',
      description: 'Cobb Salad',
      price: 5.49,
      category: 'Salad',
      imagePath: 'assets/images/dessert.png',
      count: 1,
    ),
    MenuItem(
      name: 'Caesar Salad',
      description: 'Caesar Salad',
      price: 6.59,
      category: 'Salad',
      imagePath: 'assets/images/caesar.png',
      count: 1,
    ),
    MenuItem(
      name: 'Strawberry',
      description: 'Strawberry',
      price: 7.4,
      category: 'Fruits',
      imagePath: 'assets/images/strobery.png',
      count: 1,
    ),
    MenuItem(
      name: 'Mango',
      description: 'Mango',
      price: 4.6,
      category: 'Fruits',
      imagePath: 'assets/images/mango.png',
      count: 1,
    ),
  ];

  bool isSearching = false;

  String selectedCategory = 'All';

  List<MenuItem> filteredFoods = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredFoods = List.from(allMenuItems);
  }

  void filterFoods(String query) {
    query = query.toLowerCase();
    setState(() {
      if (!isSearching) {
        searchController.clear();
        filteredFoods = List.from(allMenuItems);
      } else {
        filteredFoods = allMenuItems.where((food) {
          final name = food.name.toLowerCase();
          final description = food.description.toLowerCase();
          return name.contains(query) || description.contains(query);
        }).toList();
      }
    });
  }


  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        filteredFoods = allMenuItems;
      } else {
        filteredFoods =
            allMenuItems.where((item) => item.category == category).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: isSearching
            ? GlobalTextField(
                hintText: 'Search',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                caption: '',
                controller: searchController,
                onChanged: (query) {
                  filterFoods(query);
                },
              )
            : const Text(
                "Menu",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
        actions: [
          isSearching
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        searchController.clear();
                        filterFoods('');
                      });
                    },
                    icon: const Icon(Icons.close, color: Colors.black),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    icon: SvgPicture.asset(
                      AppImages.search,
                      width: 25,
                    ),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Categories(
              imagePaths: const [
                'assets/images/all.png',
                'assets/images/burger.png',
                'assets/images/pizza.png',
                'assets/images/chicken.png',
                'assets/images/dessert.png',
                'assets/images/strobery.png',
              ],
              categoryText: const [
                'All',
                'Burger',
                'Pizza',
                'Chicken',
                'Salad',
                'Fruits',
              ],
              onSelectedCategory: updateCategory,
            ),
            Promotions(),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text("Popular",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.63,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: filteredFoods.length,
                itemBuilder: (context, index) {
                  final item = filteredFoods[index];
                  return Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ZoomTapAnimation(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailScreen(item: item),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 140,
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Hero(
                                  tag: 'product_${item.name}',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.asset(item.imagePath),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  item.description,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white.withOpacity(0.08),
                                      ),
                                      child: Text(
                                        '\$ ${item.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    ZoomTapAnimation(
                                      onTap: () {
                                        context.read<FoodBloc>().add(
                                          AddFoodEvent(FoodModel(
                                            name: item.name,
                                            description: item.description,
                                            imagePath: item.imagePath,
                                            price: item.price,
                                            count: item.count,
                                          ))
                                        );
                                        Fluttertoast.showToast(
                                          msg: 'Successfully added to cart!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          fontSize: 16.0,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.red,
                                        ),
                                        child: const Icon(Icons.add),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
