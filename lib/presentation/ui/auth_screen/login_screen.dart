import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza/business_logic/bloc/auth/login_bloc.dart';
import 'package:pizza/generated/locale_keys.g.dart';
import 'package:pizza/presentation/ui/auth_screen/register_screen.dart';
import 'package:pizza/presentation/widgets/global_textfield.dart';
import 'package:pizza/utils/icons.dart';
import '../tab_box/tab_box.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Navigate to the next screen after successful login
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
          } else if (state is LoginFailure) {
            // Display an error message to the user
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  duration: const Duration(seconds: 5),
                ),
              );
          }
        },
        child: _buildLoginForm(context),
      ),
    );
  }

  SingleChildScrollView _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 100),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                LocaleKeys.login_desc.tr(),
                style: const TextStyle(color: Colors.black, fontFamily: 'Sora', fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                children: [
                  GlobalTextField(
                      hintText: '+(998) 99-999-99',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      caption: LocaleKeys.phone_number.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.error_phone_number.tr();
                        }
                        return null;
                      }),
                  GlobalTextField(
                    hintText: '********',
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
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.0),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const TabBox()));
                        }
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              LocaleKeys.login.tr(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey)),
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.google),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(LocaleKeys.continue_with_google.tr()),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: 1,
                  color: Colors.grey.withOpacity(0.3),
                  width: MediaQuery.of(context).size.width / 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    LocaleKeys.or.tr(),
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sora'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  height: 1,
                  color: Colors.grey.withOpacity(0.3),
                  width: MediaQuery.of(context).size.width / 3,
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: LocaleKeys.do_not_have_an_account.tr(),
                    style: const TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'Sora'),
                  ),
                  TextSpan(
                    text: LocaleKeys.sign_up.tr(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sora',
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen()));
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
