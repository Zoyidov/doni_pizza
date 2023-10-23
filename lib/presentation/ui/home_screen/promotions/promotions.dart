import 'package:flutter/material.dart';
import 'package:pizza/utils/icons.dart';

class Promotions extends StatelessWidget {
  const Promotions({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                    "Promotions",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    )
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey, Colors.black, Colors.black, Colors.black],
                  ),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 22.0),
                  child: Text(
                    "Today’s Offer\nFree box of Fries\non off orders about 150",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
            top: 0,
            child: Image.asset(
          AppImages.all,
          width: 200,
        )),
      ],
    );
  }
}
