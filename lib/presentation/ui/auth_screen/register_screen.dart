import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza/presentation/widgets/global_textfield.dart';
import 'package:pizza/utils/icons.dart';

import '../tab_box/tab_box.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: Text(
                  'Ilova orqali buyurtma berish uchun ro\'yxatdan o\'ting 👇🏻',
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
                        caption: 'Isim',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ismingizni kiriting!';
                          }
                          return null;
                        }),
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
                        }),
                    GlobalTextField(
                      hintText: '********',
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      caption: 'Parol',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Parolni kiriting!';
                        }
                        return null;
                      },
                      max: 1,
                    ),
                    GlobalTextField(
                      hintText: '********',
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      caption: 'Parol',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Parolni tasdiqlang!';
                        }
                        return null;
                      },
                      max: 1,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey),
                      ),
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
                              child: Text(
                                'Ro\'yxatdan o\'tish',
                                style: TextStyle(
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
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('Google bilan davom ettirish!'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
