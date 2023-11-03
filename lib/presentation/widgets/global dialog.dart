import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pizza/generated/locale_keys.g.dart';

class GlobalDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonYes ,
    required String buttonNo ,
    required VoidCallback onYesPressed,
    required VoidCallback onNoPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: ShapeBorder.lerp(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            0.5,
          ),
          title: Text(title,style: TextStyle(color: Colors.black,fontFamily: 'Sora',fontWeight: FontWeight.bold),),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onNoPressed();
              },
              child: Text(buttonNo,style: const TextStyle(color: Colors.black,fontFamily: 'Sora'),),
            ),
            TextButton(
              onPressed: () {
                onYesPressed();
              },
              child: Text(buttonYes,style: const TextStyle(color: Colors.red,fontFamily: 'Sora'),),
            ),
          ],
        );
      },
    );
  }
}
