import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza/widgets/global_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../utils/icons.dart';
import '../../../widgets/dialog_gallery_camera.dart';
import '../../../widgets/my_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedImagePath;
  final String profileImageKey = "profile_image";
  final String usernameKey = "User";
  final String phoneNumberKey = "+(998) __ ___ __ __";

  String? username;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    _loadUserData();
  }

  Future<void> _loadProfileImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? imagePath = prefs.getString(profileImageKey);
    if (imagePath != null) {
      setState(() {
        selectedImagePath = imagePath;
      });
    }
  }

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString(usernameKey) ?? "User";
    phoneNumber = prefs.getString(phoneNumberKey) ?? "+(998) __ ___ __ __";
    setState(() {});
  }

  Future<void> _saveProfileImage(String imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(profileImageKey, imagePath);
  }

  Future<void> _saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (username != null) {
      prefs.setString(usernameKey, username!);
    }
    if (phoneNumber != null) {
      prefs.setString(phoneNumberKey, phoneNumber!);
    }
  }

  void _clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(usernameKey);
    prefs.remove(phoneNumberKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: ClipOval(
                child: selectedImagePath != null
                    ? Image.file(
                  File(selectedImagePath!),
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  AppImages.profile,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: selectedImagePath == null
                        ? Colors.grey.shade400
                        : Colors.black,
                  ),
                  child: selectedImagePath != null
                      ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          File(selectedImagePath!),
                          height: 80,
                          width: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                      ZoomTapAnimation(
                        onTap: () {
                          showCameraAndGalleryDialog(context, (imagePath) {
                            if (imagePath != null) {
                              _saveProfileImage(imagePath);
                              setState(() {
                                selectedImagePath = imagePath;
                              });
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 18.0, top: 16),
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            CupertinoIcons.camera,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                      : ZoomTapAnimation(
                    onTap: () {
                      showCameraAndGalleryDialog(context, (imagePath) {
                        if (imagePath != null) {
                          _saveProfileImage(imagePath);
                          setState(() {
                            selectedImagePath = imagePath;
                          });
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Icon(
                        CupertinoIcons.camera,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username ?? "User",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Sora',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      phoneNumber ?? "+(998) __ ___ __ __",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Sora',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Online',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Sora',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                _saveUserData();
              },
              child: Text('Save'),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    GlobalTextField(
                      hintText: 'Name',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      caption: '',
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    GlobalTextField(
                      hintText: 'Phone number',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      caption: '',
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            ZoomTapAnimation(
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
                          )
                        ),
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          )
                        ),
                        0.5
                      ),
                      title: Text('Log Out',style: TextStyle(color: Colors.black,fontFamily: 'Sora',fontSize: 20,fontWeight: FontWeight.w600),),
                      content: Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No',style: TextStyle(color: Colors.black,fontFamily: 'Sora'),),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _clearUserData();
                          },
                          child: Text('Yes',style: TextStyle(color: Colors.red,fontFamily: 'Sora'),),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    'Log out',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 200,),
          ],
        ),
      ),
    );
  }
}
