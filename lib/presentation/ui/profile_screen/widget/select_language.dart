import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza/presentation/ui/profile_screen/widget/language_detail.dart';
import 'package:pizza/utils/icons.dart';

import '../../../../generated/locale_keys.g.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  String selectedLanguage = 'English';

  void handleLanguageChange(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          LocaleKeys.language.tr(),
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          LanguageDetail(
            textColor: Colors.black,
            icon: SvgPicture.asset(AppImages.usa, height: 30),
            text: 'English',
            showSwitch: true,
            isSelected: selectedLanguage == 'English',
            onSelected: (value) {
              context.setLocale(Locale('en'));
              if (value) {
                handleLanguageChange('English');
              }
            },
          ),
          LanguageDetail(
            textColor: Colors.black,
            icon: SvgPicture.asset(AppImages.rus, height: 30),
            text: 'Русский',
            showSwitch: true,
            isSelected: selectedLanguage == 'Русский',
            onSelected: (value) {
              context.setLocale(Locale('ru'));
              if (value) {
                handleLanguageChange('Русский');
              }
            },
          ),
          LanguageDetail(
            textColor: Colors.black,
            icon: SvgPicture.asset(AppImages.uzb, height: 30),
            text: 'Uzbek',
            showSwitch: true,
            isSelected: selectedLanguage == 'Uzbek',
            onSelected: (value) {
              context.setLocale(Locale('uz'));
              if (value) {
                handleLanguageChange('Uzbek');
              }
            },
          ),
        ],
      ),
    );
  }
}
