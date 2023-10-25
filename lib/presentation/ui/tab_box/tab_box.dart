import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/presentation/ui/cart_screen/cart_screen.dart';
import 'package:pizza/presentation/ui/home_screen/home_screen.dart';
import 'package:pizza/presentation/ui/orders/orders_screen.dart';
import 'package:pizza/presentation/ui/profile_screen/profile_screen.dart';
import '../../../data/cubit/tab_cubit.dart';
import '../../../data/database/food_database.dart';

class TabBox extends StatefulWidget {
  TabBox({Key? key}) : super(key: key);

  @override
  _TabBoxState createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  bool isDatabaseEmpty = true;

  @override
  void initState() {
    super.initState();
    checkDatabaseEmpty();
  }

  Future<void> checkDatabaseEmpty() async {
    final dbHelper = LocalDatabase.instance;
    final foodItems = await dbHelper.fetchAllFoodItems();
    setState(() {
      isDatabaseEmpty = foodItems.isEmpty;
    });
  }

  List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: context.watch<TabCubit>().state,
        children: pages,
      ),
      bottomNavigationBar: DotNavigationBar(
        backgroundColor: Colors.grey[300],
        currentIndex: context.watch<TabCubit>().state,
        onTap: context.read<TabCubit>().changeTab,
        unselectedItemColor: Colors.grey,
        items: [
          DotNavigationBarItem(
            icon: Icon(Icons.home),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: isDatabaseEmpty
                ? Icon(Icons.shopping_cart)
                : Stack(
              children: [
                Icon(Icons.shopping_cart),
                Positioned(
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.red,
                    ),
                    height: 10,
                    width: 10,
                  ),
                ),
              ],
            ),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.person),
            selectedColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
