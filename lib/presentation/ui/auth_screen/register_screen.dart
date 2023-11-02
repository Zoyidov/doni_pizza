import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/business_logic/bloc/auth/registration_bloc.dart';
import 'package:pizza/presentation/ui/auth_screen/otp_verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
    _phoneNumberController.text = '+998 94 902 01 30';
    _nameController.text = 'Islom';
    _passwordController.text = '123456';
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: _nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              controller: _phoneNumberController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Phone Number is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final registrationBloc = BlocProvider.of<RegistrationBloc>(context);
                // if (_formKey.currentState!.validate()) {
                //   Dispatch the RegisterEvent with the form data
                final name = _nameController.text;
                final phoneNumber = _phoneNumberController.text;
                final password = _passwordController.text;
                print('Go');
                registrationBloc.add(RegisterEvent(name, phoneNumber, password));
                // }
                // --------------------------------------------------------------
                // await FirebaseAuth.instance.
                // await FirebaseAuth.instance.verifyPhoneNumber(
                //   phoneNumber: '+998 94 902 01 30',
                //   verificationCompleted: (PhoneAuthCredential credential) {
                //     print('Verification completed');
                //   },
                //   verificationFailed: (FirebaseAuthException e) {
                //     print('Verification failed: ${e.message}');
                //   },
                //   codeSent: (String verificationId, int? resendToken) {
                //     print('Code sent');
                //     print(verificationId);
                //   },
                //   codeAutoRetrievalTimeout: (String verificationId) {
                //     print('Code auto retrieval timeout');
                //   },
                // );
                // --------------------------------------------------------------
                // try {
                //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
                //       email: 'islomjon21231@gmail.com', password: 'password1234');
                // } on FirebaseAuthException catch (e) {
                //   print(e.message);
                //   print(e.code);
                // } catch (e) {
                //   print(e);
                // }
              },
              child: const Text('Register'),
            ),
          ],
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
