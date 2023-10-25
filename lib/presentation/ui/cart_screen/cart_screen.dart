import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pizza/utils/icons.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/bloc/state_bloc.dart';
import '../../../data/database/food_database.dart';
import '../../../data/model/food_model.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<FoodModel> foodItems;

  @override
  void initState() {
    super.initState();
    fetchFoodItems();
  }

  Future<void> fetchFoodItems() async {
    final List<FoodModel> items =
        await LocalDatabase.instance.fetchAllFoodItems();
    setState(() {
      foodItems = items;
    });
  }

  void incrementCount(FoodModel item) {
    context.read<FoodBloc>().add(IncrementCountEvent(item));
  }

  void decrementCount(FoodModel item) {
    if (item.count == 1) {
      context.read<FoodBloc>().add(DeleteFood(item));
    } else {
      context.read<FoodBloc>().add(DecrementCountEvent(item));
    }
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
        actions:[
          IconButton(
            onPressed: () {
              context.read<FoodBloc>().add(DeleteFoods());
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                if (state is TodoInitialState || state is TodoLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FoodErrorState) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                } else if (state is FoodLoadedState) {
                  List<FoodModel> foodItems = state.foods;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        foodItems.isEmpty
                            ? Column(
                          children: [
                            SizedBox(height: 50),
                            Center(child: Lottie.asset(AppImages.empty)),]
                        ):
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: foodItems.length,
                            itemBuilder: (context, index) {
                              final item = foodItems[index];
                              return Dismissible(
                                key: Key(item.name),
                                background: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5.0),
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
                                onDismissed: (direction) async {
                                  context
                                      .read<FoodBloc>()
                                      .add(DeleteFood(item));
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5.0),
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
                                          fontFamily: 'Sora'),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                          '\$${item.price}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Sora'),
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
                                                decrementCount(item);
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
                                                incrementCount(item);
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
                          ),
                        ),
                        foodItems.isNotEmpty?
                        Padding(
                          padding: const EdgeInsets.only(bottom: 150.0),
                          child: ZoomTapAnimation(
                            onTap: (){
                              Fluttertoast.showToast(
                                timeInSecForIosWeb: 3,
                                msg: 'Ordering...🤤',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 22.0,
                              );
                            },
                              child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Center(
                                  child: Text(
                                "Book Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Sora',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              )),
                            ),
                          )),
                        ):const SizedBox(),
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text('Unknown state: $state'));
                }
              },
            ),
    );
  }
}
