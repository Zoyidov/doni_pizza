import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pizza/presentation/ui/tab_box/tab_box.dart';
import 'package:pizza/utils/icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double downloadProgress = 0.0;
  final double maxProgress = 1.0;

  @override
  void initState() {
    super.initState();

    Future<void> simulateDownloadProgress() async {
      while (downloadProgress < maxProgress) {
        await Future.delayed(Duration(milliseconds: 100));
        setState(() {
          downloadProgress += 0.1;
        });
      }

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TabBox()));
    }

    simulateDownloadProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Lottie.asset(AppImages.splash),
          Padding(
            padding: const EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0),
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(50),
              value: downloadProgress,
              minHeight: 10,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
