import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pizza/generated/locale_keys.g.dart';
import 'package:pizza/presentation/ui/auth_screen/login_screen.dart';
import 'package:pizza/presentation/ui/auth_screen/register_screen.dart';
import 'package:pizza/utils/colors.dart';
import 'package:pizza/utils/constants/sizes.dart';
import 'package:pizza/utils/constants/texts.dart';
import 'package:pizza/utils/device/device_utility.dart';
import 'package:pizza/utils/icons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                        child: Text(
                      'Doni Pizza',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )),
                    Image.asset(
                      AppImages.login,
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 1.2,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ));
                          },
                          style: ButtonStyles.roundedButtonStyle,
                          child: Text(
                            TTexts.register,
                            style: ButtonStyles.buttonTextStyle.copyWith(color: AppColors.c1E293B),
                          ),
                        ),
                      ),
                      const Gap(16),
                      Flexible(
                        fit: FlexFit.tight,
                        child: ElevatedButton(
                          style: ButtonStyles.elevatedButtonStyle,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            TTexts.login,
                            style: ButtonStyles.buttonTextStyle.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(TSizes.md),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      style: ButtonStyles.roundedButtonStyle,
                      label: Text(
                        TTexts.loginWithGoogle,
                        style: ButtonStyles.buttonTextStyle.copyWith(color: AppColors.c1E293B),
                      ),
                      icon: SvgPicture.asset(AppImages.google),
                    ),
                  ),
                  Gap(TDevice.getBottomNavigationBarHeight()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonStyles {
  static final ButtonStyle roundedButtonStyle = OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
      side: const BorderSide(color: AppColors.c1E293B),
    ),
    padding:
        const EdgeInsets.symmetric(vertical: TSizes.buttonPaddingSm, horizontal: TSizes.fontXs),
  );

  static final ButtonStyle elevatedButtonStyle = OutlinedButton.styleFrom(
    backgroundColor: AppColors.c2B8761,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    padding:
        const EdgeInsets.symmetric(vertical: TSizes.buttonPaddingSm, horizontal: TSizes.fontXs),
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.21,
    height: 1.4,
  );
}
