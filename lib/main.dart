import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza/business_logic/bloc/order_bloc.dart';
import 'package:pizza/business_logic/bloc/state_bloc.dart';
import 'package:pizza/business_logic/cubit/tab_cubit.dart';
import 'package:pizza/presentation/ui/splash_screen/splash_screen.dart';
import 'package:pizza/presentation/ui/tab_box/tab_box.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'data/database/orders_database.dart';

void main() async {
  runApp(const MyApp());
  // Fluttertoast.showToast(msg: "App initialized");
  await OrderDatabase.instance.initDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<TabCubit>(
          create: (context) => TabCubit(),
          child: const TabBox(),
        ),
        BlocProvider(create: (context) => FoodBloc()..add(LoadTodosEvent())),
        BlocProvider(create: (context) => OrderBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
