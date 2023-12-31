import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza/business_logic/bloc/state_bloc.dart';
import 'package:pizza/generated/locale_keys.g.dart';
import 'package:pizza/presentation/ui/orders/order_detail.dart';
import 'package:pizza/utils/icons.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/database/food_database.dart';
import '../../../data/model/food_model.dart';
import '../../widgets/global dialog.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<FoodModel> foodItems;
  bool showLottie = false;

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

    double newTotalCost = calculateTotalPrice(foodItems);

    context.read<FoodBloc>().add(UpdateTotalCostEvent(newTotalCost));
  }

  void decrementCount(FoodModel item) {
    if (item.count == 1) {
      context.read<FoodBloc>().add(DeleteFood(item));
    } else {
      context.read<FoodBloc>().add(DecrementCountEvent(item));
    }

    double newTotalCost = calculateTotalPrice(foodItems);

    context.read<FoodBloc>().add(UpdateTotalCostEvent(newTotalCost));
  }

  double calculateTotalPrice(List<FoodModel> foodItems) {
    double totalPrice = 0.0;
    for (final food in foodItems) {
      totalPrice += food.count * food.price;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          LocaleKeys.cart.tr(),
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        actions: [
          ZoomTapAnimation(
            onTap: () {
              GlobalDialog.show(
                context: context,
                title: LocaleKeys.clear_cart.tr(),
                message:
                    LocaleKeys.sure_to_clear_cart.tr(),
                buttonYes: LocaleKeys.clear.tr(),
                onYesPressed: () {
                  Navigator.of(context).pop();
                  context.read<FoodBloc>().add(DeleteFoods());
                },
                buttonNo: LocaleKeys.cancel.tr(),
                onNoPressed: () {
                  Navigator.of(context).pop();
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Center(
                child: Text(
                  LocaleKeys.clear.tr(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is TodoInitialState || state is FoodLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FoodErrorState) {
            return Center(child: Text(state.errorMessage));
          } else if (state is FoodLoadedState) {
            List<FoodModel> foodItems = state.foods;
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: foodItems.isEmpty
                    ? Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppImages.empty_cart),
                              SizedBox(height: 32.0),
                              Text(
                                LocaleKeys.empty_cart.tr(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: 'Sora',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: foodItems.length,
                              itemBuilder: (context, index) {
                                final item = foodItems[index];
                                return Dismissible(
                                  key: Key(item.name),
                                  background: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0),
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0),
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${item.price}${LocaleKeys.usd.tr()}',
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
                          foodItems.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 130.0, top: 5.0),
                                  child: ZoomTapAnimation(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailScreen(
                                            foodItems: foodItems,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.black,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15.0),
                                        child: Center(
                                          child: Text(
                                            "${LocaleKeys.order_now.tr()}  /${calculateTotalPrice(foodItems).toStringAsFixed(2)}${LocaleKeys.usd.tr()}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Sora',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ));
          } else {
            return Center(child: Text('Unknown state: $state'));
          }
        },
      ),
    );
  }
}
