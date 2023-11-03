import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';

class CurrentOrderScreen extends StatefulWidget {
  const CurrentOrderScreen({super.key});

  @override
  State<CurrentOrderScreen> createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
  String getCurrentTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm').format(now);
    return formattedTime;
  }

  String getFutureTime() {
    final now = DateTime.now();
    final futureTime = now.add(Duration(minutes: 40));
    final formattedTime = DateFormat('HH:mm').format(futureTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Column(
              children: [
                Text(
                  "Yetkaziladigan vaqt: ${getCurrentTime()} - ${getFutureTime()}",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Buyurtmani Doni Pizza tomonidan tasdiqlash 3-5 daqiqa vaqt oladi.",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                ConditionIcons()
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class ConditionIcons extends StatelessWidget {
  const ConditionIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
                color: Colors.grey.shade200),
            child: Icon(
              Icons.watch_later,
              color: Colors.indigo,
            )),
        Container(
          height: 20,
          width: 20,
          color: Colors.grey.shade200,
        ),
        Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
              color: Colors.grey.shade200),
          child: Icon(
            Icons.restaurant_menu,
            color: Colors.black,
          ),
        ),
        Container(
          height: 20,
          width: 20,
          color: Colors.grey.shade200,
        ),
        Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
              color: Colors.grey.shade200),
          child: Icon(
            Icons.directions_run,
            color: Colors.black,
          ),
        ),
        Container(
          height: 20,
          width: 20,
          color: Colors.grey.shade200,
        ),
        Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  topRight: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
              color: Colors.grey.shade200),
          child: Icon(
            Icons.file_download_done,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
