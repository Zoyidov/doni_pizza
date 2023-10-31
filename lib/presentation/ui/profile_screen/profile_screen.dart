import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pizza/presentation/widgets/dialog_gallery_camera.dart';
import 'package:pizza/presentation/widgets/global_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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
      final appDocDir = await getApplicationDocumentsDirectory();
      final localPath = '${appDocDir.path}/$profileImageKey.jpg';
      final file = File(localPath);

      if (file.existsSync()) {
        setState(() {
          selectedImagePath = localPath;
        });
      }
    }
  }

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString(usernameKey) ?? "User";
    phoneNumber = prefs.getString(phoneNumberKey) ?? "+(998) __ ___ __ __";

    final String? imagePath = prefs.getString(profileImageKey);
    if (imagePath != null) {
      try {
        final file = File(imagePath);
        if (file.existsSync()) {
          final extractedPath = imagePath
              .substring(imagePath.indexOf("/private/var/mobile/Containers/Data/Application/"));
          selectedImagePath = extractedPath;
        } else {}
        // ignore: empty_catches
      } catch (e) {}
    }

    setState(() {});
  }

  Future<void> saveProfileImage(String imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(profileImageKey, imagePath);

    final appDocDir = await getApplicationDocumentsDirectory();
    final localPath = '${appDocDir.path}/$profileImageKey.jpg';
    final imageFile = File(imagePath);
    await imageFile.copy(localPath);
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
        automaticallyImplyLeading: false,
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              child: ClipOval(
                  child: selectedImagePath != null
                      ? Image.file(
                          File(selectedImagePath!),
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.person, color: Colors.black)),
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
                                    saveProfileImage(imagePath);
                                    setState(() {
                                      selectedImagePath = imagePath;
                                    });
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 18.0, top: 16, right: 18.0),
                                padding: const EdgeInsets.all(10.0),
                                child: const Icon(
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
                                saveProfileImage(imagePath);
                                setState(() {
                                  selectedImagePath = imagePath;
                                });
                              }
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(26.0),
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
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Sora',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      phoneNumber ?? "+(998) __ ___ __ __",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Sora',
                        fontSize: 16,
                      ),
                    ),
                    const Text(
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
              child: const Text('Save'),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
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
                    const SizedBox(height: 10.0),
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
                          )),
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          )),
                          0.5),
                      title: const Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Sora',
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      content: const Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(color: Colors.black, fontFamily: 'Sora'),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _clearUserData();
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.red, fontFamily: 'Sora'),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.red,
                ),
                child: const Center(
                  child: Text(
                    'Delete user data!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
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
