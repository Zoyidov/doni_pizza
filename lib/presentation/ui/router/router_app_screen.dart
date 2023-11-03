import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/business_logic/cubit/auth_user_cubit/auth_user_cubit.dart';
import 'package:pizza/presentation/ui/auth_screen/welcom_screen.dart';
import 'package:pizza/presentation/ui/tab_box/tab_box.dart';

class RouterApp extends StatelessWidget {
  const RouterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthUserCubit, User?>(
      builder: (context, state) {
        if (state == null) {
          return const WelcomeScreen();
        } else {
          return const TabBox();
        }
      },
      listener: (BuildContext context, User? state) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const RouterApp(),
          ),
          (route) => false,
        );
      },
    );
  }
}
