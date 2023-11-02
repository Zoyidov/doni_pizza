import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:pizza/generated/locale_keys.g.dart';
import 'dart:async';

import '../tab_box/tab_box.dart';

class ConfirmVerificationCodeScreen extends StatefulWidget {
  const ConfirmVerificationCodeScreen({super.key});

  @override
  State<ConfirmVerificationCodeScreen> createState() =>
      _ConfirmVerificationCodeScreenState();
}

class _ConfirmVerificationCodeScreenState
    extends State<ConfirmVerificationCodeScreen> {
  int _remainingSeconds = 60;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String formatRemainingTime() {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  void resendCode() {
    setState(() {
      _remainingSeconds = 60;
    });
    startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 150,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Pinput(
                      validator: (s) {
                        return s == '2222' ? null : LocaleKeys.error_code.tr();
                      },
                      focusedPinTheme: PinTheme(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      defaultPinTheme: PinTheme(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      errorPinTheme: PinTheme(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      crossAxisAlignment: CrossAxisAlignment.center,
                      hapticFeedbackType: HapticFeedbackType.vibrate,
                      errorText: LocaleKeys.error_code.tr(),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onCompleted: (pin) {
                        if (pin == '2222') {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const TabBox(),
                              )
                          );
                        }
                      }
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(LocaleKeys.code_sent.tr()),
                  Text(LocaleKeys.enter_code.tr()),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    '${LocaleKeys.resend_in.tr()} ${formatRemainingTime()}',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_remainingSeconds == 0) {
                        resendCode();
                      }
                    },
                    child: Text(
                      _remainingSeconds == 0 ? LocaleKeys.resend_code.tr() : LocaleKeys.resend_code_disable.tr(),
                      style: TextStyle(
                        color:
                        _remainingSeconds == 0 ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
