import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pizza/business_logic/bloc/auth/login_bloc.dart';
import 'package:pizza/generated/locale_keys.g.dart';
import 'package:pizza/presentation/ui/auth_screen/register_screen.dart';
import 'package:pizza/presentation/ui/auth_screen/welcom_screen.dart';
import 'package:pizza/generated/locale_keys.g.dart';
import 'package:pizza/presentation/ui/auth_screen/register_screen.dart';
import 'package:pizza/presentation/ui/profile_screen/widget/select_language.dart';
import 'package:pizza/presentation/widgets/global_textfield.dart';
import 'package:pizza/utils/colors.dart';
import 'package:pizza/utils/constants/sizes.dart';
import 'package:pizza/utils/constants/texts.dart';
import 'package:pizza/utils/device/device_utility.dart';
import 'package:pizza/utils/dialogs/snackbar_dialogs.dart';
import 'package:pizza/utils/fonts/fonts.dart';
import 'package:pizza/utils/formatters/formatter.dart';
import 'package:pizza/utils/icons.dart';
import 'package:pizza/utils/logging/logger.dart';
import '../../../business_logic/bloc/auth/registration_bloc.dart';
import '../tab_box/tab_box.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: -15,
      ),
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            TLoggerHelper.info("Success");
            // Navigator.pushAndRemoveUntil(
            //     context, MaterialPageRoute(builder: (context) => const TabBox()), (route) => false);
          } else if (state is LoginFailure) {
            // Display an error message to the user
            TDialog.showAlert(context: context, message: state.error);
          }
        },
        child: _buildLoginForm(context),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                  height: 143,
                  child: Center(
                    child: Text(TTexts.login,
                        style: TFonts.titleScreen.copyWith(color: AppColors.c1E293B)),
                  )),
              // Padding(
              //   padding: const EdgeInsets.symmetric(),
              //   child: Text(
              //     LocaleKeys.login_desc.tr(),
              //     style: const TextStyle(color: Colors.black, fontFamily: 'Sora', fontSize: 18),
              //   ),
              // ),

              Column(
                children: [
                  GlobalTextField(
                      hintText: '+(998) 99-999-99',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      caption: LocaleKeys.phone_number.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.error_password.tr();
                        }
                        return null;
                      }),
                  const Gap(TSizes.sm),
                  GlobalTextField(
                    hintText: '********',
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    caption: LocaleKeys.password.tr(),
                    max: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.error_password.tr();
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const Gap(TSizes.lg),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  final isLoading = state is LoginLoading;
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ButtonStyles.elevatedButtonStyle,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(PhoneLoginEvent(
                              phoneNumber: TFormatter.convertPhoneNumberToEmail(
                                  _phoneController.text.trim()),
                              password: _passwordController.text.trim()));
                        }
                      },
                      icon: isLoading
                          ? const SizedBox.square(
                              dimension: TSizes.sm,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ))
                          : const SizedBox(),
                      label: Text(
                        TTexts.login,
                        style: ButtonStyles.buttonTextStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
              const Gap(TSizes.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: Divider(endIndent: 16)),
                  Text(
                    LocaleKeys.or.tr(),
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sora'),
                  ),
                  const Expanded(child: Divider(indent: 16)),
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

              // RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: LocaleKeys.do_not_have_an_account.tr(),
              //         style: const TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'Sora'),
              //       ),
              //       TextSpan(
              //         text: LocaleKeys.sign_up.tr(),
              //         style: const TextStyle(
              //           color: Colors.red,
              //           fontSize: 15,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: 'Sora',
              //           decoration: TextDecoration.underline,
              //         ),
              //         recognizer: TapGestureRecognizer()
              //           ..onTap = () {
              //             Navigator.push(context,
              //                 MaterialPageRoute(builder: (context) => const RegisterScreen()));
              //           },
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 100,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
