import 'package:flutter/material.dart';
import 'package:pizza/presentation/ui/tab_box/tab_box.dart';
import 'package:pizza/utils/icons.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              AppImages.splash,
              fit: BoxFit.cover,
              height: 300,
            ),
          ),
          SizedBox(height: 20,),
          Column(
            children: [
              const Text(
                'Nuri Pizza',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Sora'),
              ),
              Image.asset(
                AppImages.pizza,
                width: 100,
              ),
            ],
          ),
          const Spacer(),
          ZoomTapAnimation(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TabBox()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }
}
