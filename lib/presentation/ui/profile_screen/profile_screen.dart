import 'package:flutter/material.dart';

import '../../../utils/icons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w600,
              fontSize: 30),
        ),
        actions: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: ClipOval(
                  child: Image.asset(
                    AppImages.splash,
                    fit: BoxFit.cover,
                    height: 40,
                  ),
                ),
              ),
            ),
        ],

      ),
    );
  }
}
