import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 80),
                Center(
                    child: Text(
                  'Doni Pizza',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )),
                Image.asset(
                  AppImages.pizza,
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20.0),
                  child: Text('Ilova orqali buyurtma berish uchun shaxsiy Accountingizga kiring 👇🏻',style: TextStyle(color: Colors.black,fontFamily: 'Sora',fontSize: 18),),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                  child: Column(
                    children: [
                      GlobalTextField(
                          hintText: '+(998) 99-999-99',
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          caption: 'Telefon raqam',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Telefon raqamingizni kiriting!';
                            }
                            return null;
                          }
                      ),
                      GlobalTextField(
                        hintText: '********',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        caption: 'Parol',
                        max: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Parol noto\'g\'ri kiritildi!';
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey),),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.0),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TabBox()));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text('Kirish',style: TextStyle(color: Colors.black,fontFamily: 'Sora',fontWeight: FontWeight.bold),),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, ),
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
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Google bilan davom ettirish!'),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      height: 1,
                      color: Colors.grey.withOpacity(0.3),
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'yoki',
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sora'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
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
                        text: 'Accountingiz mavjud emasmi?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Sora'),
                      ),
                      TextSpan(
                        text: ' Ro\'yxatdan o\'ting',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sora',
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
