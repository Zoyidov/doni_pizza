// ignore_for_file: library_private_types_in_public_api

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/business_logic/cubit/tab_cubit.dart';
import 'package:pizza/presentation/ui/cart_screen/cart_screen.dart';
import 'package:pizza/presentation/ui/home_screen/home_screen.dart';
import 'package:pizza/presentation/ui/orders/orders_screen.dart';
import 'package:pizza/presentation/ui/profile_screen/profile_screen.dart';
import '../../../data/database/food_database.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

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
            icon: const Icon(Icons.home),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: Badge(
              label: Text('7'),
              child: Icon(Icons.shopping_cart),
            ),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: Badge(
              label: Text('1'),
              child: Icon(Icons.access_time_outlined),
            ),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.person),
            selectedColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
