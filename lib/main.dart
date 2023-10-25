import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza/presentation/ui/splash_screen/splash_screen.dart';
import 'package:pizza/presentation/ui/tab_box/tab_box.dart';
import 'package:provider/provider.dart';


import 'data/bloc/state_bloc.dart';
import 'data/cubit/tab_cubit.dart';

void main() async {
  runApp(const MyApp());
  Fluttertoast.showToast(msg: "App initialized");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<TabCubit>(
          create: (context) => TabCubit(),
          child:  TabBox(),
        ),
        BlocProvider(create: (context) => FoodBloc()..add(LoadTodosEvent())),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}