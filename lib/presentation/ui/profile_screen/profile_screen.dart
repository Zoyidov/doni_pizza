import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza/generated/locale_keys.g.dart';
import 'package:pizza/presentation/ui/auth_screen/login_screen.dart';
import 'package:pizza/presentation/ui/profile_screen/widget/about_us.dart';
import 'package:pizza/presentation/ui/profile_screen/widget/admin_screen.dart';
import 'package:pizza/presentation/ui/profile_screen/widget/edit_profile.dart';
import 'package:pizza/presentation/ui/profile_screen/widget/select_language.dart';
import 'package:pizza/presentation/widgets/dialog_gallery_camera.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../cart_screen/cart_screen.dart';
import 'widget/profile_detail.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key,});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedImagePath;
  final String profileImageKey = "profile_image";
  String? username;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          LocaleKeys.profile.tr(),
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, bottom: 5.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUsScreen()));
              },
              icon: const Icon(Icons.account_balance_outlined, color: Colors.black),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ZoomTapAnimation(
              onTap: () {
                showCameraAndGalleryDialog(context, (imagePath) {
                  if (imagePath != null) {
                    setState(() {
                      selectedImagePath = imagePath;
                    });
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: selectedImagePath == null ? Colors.grey.shade400 : Colors.black,
                ),
                child: selectedImagePath != null
                    ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.file(
                        File(selectedImagePath!),
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )
                    : const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Icon(
                    CupertinoIcons.camera,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  LocaleKeys.user.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Sora',
                    fontSize: 20,
                  ),
                ),
                const Text(
                  "+(998) __ ___ __ __",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Sora',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  ProfileDetail(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                    },
                    textColor: Colors.black,
                    icon: const Icon(Icons.person),
                    text: LocaleKeys.my_profile.tr(),
                    showArrow: true, showSwitch: false,
                  ),
                  ProfileDetail(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectLanguage()));
                    },
                    textColor: Colors.black,
                    icon: const Icon(Icons.language),
                    text: LocaleKeys.language.tr(),
                    showArrow: true,
                    showSwitch: false,
                  ),
                  // ProfileDetail(
                  //   textColor: Colors.black,
                  //   icon: const Icon(Icons.access_time_outlined),
                  //   text: 'Save Orders',
                  //   showArrow: false,
                  //   showSwitch: true,
                  // ),
                  ProfileDetail(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminScreen()));
                    },
                    textColor: Colors.black,
                    icon: const Icon(Icons.admin_panel_settings_rounded),
                    text: LocaleKeys.app_admin.tr(),
                    showArrow: true,
                    showSwitch: false,
                  ),
                  ProfileDetail(
                    onTap: () {
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
                            title: Text(
                              LocaleKeys.logout.tr(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sora',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            content: Text(LocaleKeys.logout_popup.tr()),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  LocaleKeys.no.tr(),
                                  style: TextStyle(color: Colors.black, fontFamily: 'Sora'),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                                },
                                child: Text(
                                  LocaleKeys.yes.tr(),
                                  style: TextStyle(color: Colors.red, fontFamily: 'Sora'),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    textColor: Colors.black,
                    icon: const Icon(Icons.logout, color: Colors.red),
                    text: LocaleKeys.logout.tr(),
                    showArrow: false,
                    showSwitch: false,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}