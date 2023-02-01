import 'package:flutter/material.dart';
import '../../language/app_words.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../widget/drawers.dart';
import '../widget/icon_social_media.dart';
import '../widget/main_text.dart';
import '../widget/mediat_text.dart';

class AboutUs extends StatelessWidget {
  static const id = "/AboutUs";

  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: MediatText(
          text: AppWords.appName,
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      drawer: const Drawers(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: Dimensions.height100 + 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.height100 - 20),
                    child: const Center(
                      child: MainText(
                        text: AppWords.aboutUs,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Padding(

                  padding: EdgeInsets.only(top: Dimensions.height100),
                  child: Container(

                    height: Dimensions.height100 + 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.width45),
                        topLeft: Radius.circular(Dimensions.width45),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.height45 - 15),
                      child: Image.asset("assets/images/logo/logo.png"),
                    ),
                  ),
                ),
              ],
            ),
            const MainText(text: "Our Lovely Team",color:AppColors.mainColor,fontWeight: FontWeight.bold,),
            SizedBox(height: Dimensions.height20,),
            MediatText(text: "Ahmad Alrai\t 61830057",color:AppColors.mainColor,fontWeight: FontWeight.bold,),
            SizedBox(height: Dimensions.height20,),
            MediatText(text: "Aiman Mohammed Hdi\t 61810060",color:AppColors.mainColor,fontWeight: FontWeight.bold,),
            SizedBox(height: Dimensions.height20,),
            MediatText(text: "Assad\t 61830057",color:AppColors.mainColor,fontWeight: FontWeight.bold,),
            SizedBox(height: Dimensions.height20,),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  shadowColor: Colors.black,
                  color: AppColors.textColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [

                        IconSocialMedia(
                          onTap: () { "https://web.whatsapp.com/";},
                          image: 'assets/images/icons/facebook.png',
                        ),
                        SizedBox(width: Dimensions.width20,),
                        Text("khedmafaceboook"),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  shadowColor: Colors.black,
                  color: AppColors.textColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconSocialMedia(
                          onTap: () { "https://web.whatsapp.com/";},
                          image: 'assets/images/icons/whatsapp.png',
                        ),
                        SizedBox(width: Dimensions.width20,),
                        Text("777912466"),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  shadowColor: Colors.black,
                  color: AppColors.textColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconSocialMedia(
                          onTap: () { "https://web.whatsapp.com/";},
                          image: 'assets/images/icons/instagram.png',
                        ),
                        SizedBox(width: Dimensions.width20,),
                        Text("khedmainstagram"),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  shadowColor: Colors.black,
                  color: AppColors.textColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconSocialMedia(
                          onTap: () { "https://web.whatsapp.com/";},
                          image: 'assets/images/icons/twitter.jpg',
                        ),
                        SizedBox(width: Dimensions.width20,),
                        Text("khedmatiwtter"),
                      ],
                    ),
                  ),
                ),

              ],
            ),

          ],

        ),
      ),

    );
  }
}
