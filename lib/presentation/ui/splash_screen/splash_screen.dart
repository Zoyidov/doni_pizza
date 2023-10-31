import 'package:flutter/material.dart';
import 'package:pizza/presentation/ui/tab_box/tab_box.dart';
import 'package:pizza/utils/icons.dart';

import '../auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation = Tween<Offset>(
      begin: Offset(4, -4),
      end: Offset(0, -6),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            AppImages.splashj,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: SlideTransition(
              position: _animation,
              child: Text(
                "Bomisilar eee 😅",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sora',
                  letterSpacing: 5.0,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(3, 3),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
