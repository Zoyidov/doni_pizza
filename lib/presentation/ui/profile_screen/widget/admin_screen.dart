import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza/utils/icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  Future<void> _sendEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    }
  }

  Future<void> _makeCall(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunch(phoneLaunchUri.toString())) {
      await launch(phoneLaunchUri.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Icon(CupertinoIcons.wrench_fill, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                """Tizimda muammolar paydo bo'lsa, Ilova developer lari bilan bog'laning!\n\nUlar bilan bog'lanish uchun quyidagi ma'lumotlarni ishlatishingiz mumkin:
""",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Sora',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text("Developer Islomjon:\n",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Sora',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  )),
              Row(
                children: [
                  Text(
                    "Email: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () => _sendEmail("islomjon20010930@gmail.com"),
                    child: Row(
                      children: [
                        Text(
                          "islomjon20010930@gmail.com   ",
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Sora',
                            fontSize: 13,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Icon(Icons.email,color: CupertinoColors.systemOrange,)
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Telefon: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: () => _makeCall("+998949020130"),
                    child: Row(
                      children: [
                        Text(
                          "+(998)-94-902-01-30   ",
                          style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: 'Sora',
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Icon(Icons.phone,color: CupertinoColors.activeGreen,)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.0,),
              Text("Developer Nurmuxammad:\n",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Sora',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  )),
              Row(
                children: [
                  Text(
                    "Email: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () => _sendEmail("nurmuhammadzoyidov@gmail.com"),
                    child: Row(
                      children: [
                        Text(
                          "nurmuhammadzoyidov@gmail.com   ",
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Sora',
                            fontSize: 13,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Icon(Icons.email,color: CupertinoColors.systemOrange,)
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Telefon: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: () => _makeCall("+998912719555"),
                    child: Row(
                      children: [
                        Text(
                          "+(998)-91-271-95-55   ",
                          style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: 'Sora',
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Icon(Icons.phone,color: CupertinoColors.activeGreen,)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              Center(child: SvgPicture.asset(AppImages.dev)),
              Text("Taklif va Shikoyatlar uchun"),

            ],
          ),
        ),
      ),
    );
  }
}
