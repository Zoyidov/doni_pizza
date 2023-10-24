import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/database/food_database.dart';
import '../../../data/model/food_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<FoodItem> foodItems;

  @override
  void initState() {
    super.initState();
    fetchFoodItems();
  }

  Future<void> fetchFoodItems() async {
    final List<FoodItem> items = await FoodDatabaseHelper.instance.fetchAllFoodItems();
    setState(() {
      foodItems = items;
    });
  }

  void incrementCount(int index) {
    setState(() {
      foodItems[index].count++;
    });
  }

  void decrementCount(int index) {
    setState(() {
      if (foodItems[index].count > 1) {
        foodItems[index].count--;
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
        backgroundColor: Colors.white,
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FoodDatabaseHelper.instance.deleteAll();
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<FoodItem>>(
                future: FoodDatabaseHelper.instance.fetchAllFoodItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: foodItems?.length,
                      itemBuilder: (context, index) {
                        final item = foodItems[index];
                        return Dismissible(
                          key: Key(item.name),
                          background: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red,
                            ),
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {},
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black.withOpacity(0.1),
                            ),
                            child: ListTile(
                              leading: Image.asset(
                                item.imagePath,
                                width: 80,
                                height: 80,
                              ),
                              title: Text(
                                item.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Sora'

                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    '\$${item.price}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Sora'
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.black87,
                                        ),
                                        onPressed: () {
                                          decrementCount(index);
                                        },
                                      ),
                                      Text(
                                        item.count.toString(),
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.black87,
                                        ),
                                        onPressed: () {
                                          incrementCount(index);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 150.0),
              child: ZoomTapAnimation(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Center(child: Text("Book Now",style: TextStyle(color: Colors.white,fontFamily: 'Sora',fontWeight: FontWeight.w500,fontSize: 16),)),
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
