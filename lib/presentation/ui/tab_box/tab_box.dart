import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/presentation/ui/cart_screen/cart_screen.dart';
import 'package:pizza/presentation/ui/home_screen/home_screen.dart';
import 'package:pizza/presentation/ui/profile_screen/profile_screen.dart';
import '../../../data/cubit/tab_cubit.dart';

class TabBox extends StatelessWidget {
  TabBox({super.key});

  List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
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
        backgroundColor: Color(0xFFDDD7D7),
        currentIndex: context.watch<TabCubit>().state,
        onTap: context.read<TabCubit>().changeTab,
        unselectedItemColor: Colors.grey,
        items: [
          DotNavigationBarItem(
            icon: Icon(Icons.home),
            selectedColor: Colors.black,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
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
