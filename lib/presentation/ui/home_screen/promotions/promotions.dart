import 'package:flutter/material.dart';
import 'package:pizza/utils/icons.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Promotions extends StatelessWidget {
  final List<String> promotionTexts = [
    "Order any large pizza\nand get a free appetizer of your choice. Don't miss out on our delicious deals every Monday!",
    "Enjoy the weekend\nwith our family meal deal - 2 large pizzas, 4 drinks, and a dessert for just \$40. Perfect for family gatherings!",
    "Get 30% off on any\npasta dish when you order with any pizza. Indulge in our mouthwatering pasta options today.",
    "Join our loyalty\nprogram and earn points with every order. Redeem your points for exclusive discounts and freebies!",
    "Are you a student?\nShow your student ID and get 15% off your entire order. Affordable meals for hardworking students!"
  ];

  Promotions({super.key});


  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 1.6,
        enlargeCenterPage: true,
        viewportFraction: 1,
        autoPlayInterval: const Duration(seconds: 2),
      ),
      items: promotionTexts.map((text) {
        return ZoomTapAnimation(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Text(
                        "Promotions",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.grey, Colors.black, Colors.black, Colors.black],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                        child: Text(
                          text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Sora',
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
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
