import 'package:flutter/material.dart';

class TDialog {
  static void showInformation({required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      // action: SnackBarAction(label: 'Retry', onPressed: () {}),
      dismissDirection: DismissDirection.horizontal,
      // closeIconColor: TAppColors.white,
      // showCloseIcon: true,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccess({required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showWarning({required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.amberAccent[700],
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showAlert({required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
