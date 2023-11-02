import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Doni Pizza Ilovasi Haqida',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Sora',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                """Doni Pizza, tez taom yetkazib berish uchun sizning xizmatingizda. Islomjon Nabijonov va Zoyidov Nurmuxammad tomonidan yaratilgan, bizning ilovamiz sevimli taomlaringizni tez va qulay buyurtma berishni oson qilish maqsadida yaratilgan. Biz har kuni zamonaviy retseptlarni taklif qilamiz va sizga sifatli taomlarni tayyorlash va ularga yetkazish imkoniyatini beramiz.
          
          Doni Pizza ilovasi bilan, biz sizga har xil tez taomlar uchun eng yaxshi tanlovlarni tavsiya qilamiz. Siz o'zingizga qulayroqlik, tezlik va kerakli ma'lumotlarni topishingiz mumkin, ya'ni eng yaqin Doni Pizza restoranlari yoki yetkazib berish hamkorlarimiz haqida ma'lumotlarni topishingiz mumkin.
          
          Bizning ilovamiz, sizga ekspenslarini optimallashtirish, aktsiyalarni va chegirmalar kodi bilan oziq-ovqat sarflash imkonini taqdim etadi. Qo'shimcha ravishda, u sizga ilovangiz ichidan istalgan taomlarni tanlash imkonini beradi, ya'ni o'zingizni sevimli restoranlardan taomlarni tanlash va maxsuslashtirish imkonini beradi.
          
          Doni Pizza ilovasi, sizning oziq-ovqat xarajatlaringizni optimallashtiradi va tez taom buyurtma berishni oson qiladi. U internet ulanishini talab qilmaydi va sizga telefon va GPSni boshqarish imkonini beradi.
          
          Doni Pizza ilovasi, oziq-ovqat xarajatlaringizni kamaytirish va tez taom yetkazib berishni oson qiladi. Ilovamizni endi ishlatib, Doni Pizza ovqatlaringizni eshikqa yetkazing!
          """,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Sora',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
