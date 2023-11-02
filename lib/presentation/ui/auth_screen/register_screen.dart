import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/business_logic/bloc/auth/registration_bloc.dart';
import 'package:pizza/presentation/ui/auth_screen/otp_verification_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza/presentation/widgets/global_textfield.dart';
import 'package:pizza/utils/icons.dart';

import '../../../generated/locale_keys.g.dart';
import '../tab_box/tab_box.dart';
import 'confirm_verification_code.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? passwordsMatch(String? value) {
    if (passwordController.text.length < 8) {
      return LocaleKeys.password_length_error.tr();
    }

    if (value != passwordController.text) {
      return LocaleKeys.password_does_not_match.tr();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          print('$state-----------------------------------');
          if (state is RegistrationCodeSent) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OTPVerificationScreen(),
              ),
            );
            // navigateToOTPScreen();
            print(state);
          } else if (state is RegistrationFailure) {
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
        child: _buildRegistrationForm(context),
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
   
    return  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: Text(
                  LocaleKeys.auth_desc.tr(),
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Sora', fontSize: 18),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Column(
                  children: [
                    GlobalTextField(
                        hintText: 'Doni Pizza',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        caption: LocaleKeys.Name.tr(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.enter_name.tr();
                          }
                          return null;
                        }),
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
                      textInputAction: TextInputAction.next,
                      caption: LocaleKeys.password.tr(),
                      controller: passwordController,
                      validator: passwordsMatch,
                      max: 1,
                    ),
                    GlobalTextField(
                      hintText: '********',
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      caption: LocaleKeys.confirm_password.tr(),
                      controller: confirmPasswordController,
                      validator: passwordsMatch,
                      max: 1,
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
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) =>
                                    const ConfirmVerificationCodeScreen(),
                              ));
                            }
                          }
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                LocaleKeys.sign_up.tr(),
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
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey)),
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
                          Text(
                            LocaleKeys.continue_with_google.tr(),
                          ),
                        ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),

        ),
      ),
    );
  }

// The rest of your widget code...
}

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pizza/business_logic/bloc/auth/registration_bloc.dart';
// import 'package:pizza/presentation/ui/auth_screen/otp_verification_screen.dart';
// import 'package:pizza/presentation/widgets/global_textfield.dart';
// import 'package:pizza/utils/icons.dart';
//
// import '../../../generated/locale_keys.g.dart';
// import '../tab_box/tab_box.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: BlocListener<RegistrationBloc, RegistrationState>(
//         listener: (context, state) {
//           if (state is RegistrationSuccess) {
//             // Navigate to the next screen after successful registration
//             Navigator.pushReplacement(
//                 context, MaterialPageRoute(builder: (context) => OTPVerificationScreen()));
//           } else if (state is RegistrationFailure) {
//             // Display an error message to the user
//             ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(
//                 SnackBar(
//                   content: Text(state.error),
//                   duration: Duration(seconds: 5),
//                 ),
//               );
//           }
//         },
//         child: _buildRegistrationForm(context),
//       ),
//     );
//   }
//
//   SingleChildScrollView _buildRegistrationForm(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             const SizedBox(height: 100),
//             const Center(
//                 child: Text(
//               'Doni Pizza',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Sora',
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30),
//             )),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//               child: Text(
//                 LocaleKeys.auth_desc.tr(),
//                 style: TextStyle(color: Colors.black, fontFamily: 'Sora', fontSize: 18),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
//               child: Column(
//                 children: [
//                   GlobalTextField(
//                       hintText: 'Doni Pizza',
//                       keyboardType: TextInputType.name,
//                       textInputAction: TextInputAction.next,
//                       caption: LocaleKeys.Name.tr(),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Ismingizni kiriting!';
//                         }
//                         return null;
//                       }),
//                   GlobalTextField(
//                       hintText: '+(998) 99-999-99',
//                       keyboardType: TextInputType.phone,
//                       textInputAction: TextInputAction.next,
//                       caption: LocaleKeys.phone_number.tr(),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return LocaleKeys.error_phone_number.tr();
//                         }
//                         return null;
//                       }),
//                   GlobalTextField(
//                     hintText: '********',
//                     keyboardType: TextInputType.visiblePassword,
//                     textInputAction: TextInputAction.done,
//                     caption: LocaleKeys.password.tr(),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return LocaleKeys.enter_password.tr();
//                       }
//                       return null;
//                     },
//                     max: 1,
//                   ),
//                   GlobalTextField(
//                     hintText: '********',
//                     keyboardType: TextInputType.visiblePassword,
//                     textInputAction: TextInputAction.done,
//                     caption: LocaleKeys.confirm_password.tr(),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return LocaleKeys.confirm_password.tr();
//                       }
//                       return null;
//                     },
//                     max: 1,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 20.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: Colors.grey),
//                     ),
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(16.0),
//                       onTap: () {
//                         if (_formKey.currentState!.validate()) {
//                           Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(builder: (context) => const TabBox()));
//                         }
//                       },
//                       child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Center(
//                             child: Text(
//                               LocaleKeys.sign_up.tr(),
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontFamily: 'Sora',
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           )),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(
//                 horizontal: 16.0,
//               ),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey)),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(16.0),
//                 onTap: () {},
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                     SvgPicture.asset(AppImages.google),
//                     const SizedBox(
//                       width: 10.0,
//                     ),
//                     Text(
//                       LocaleKeys.continue_with_google.tr(),
//                     ),
//                   ]),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 100,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
