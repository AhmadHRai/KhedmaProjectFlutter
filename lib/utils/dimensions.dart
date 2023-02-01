import 'package:get/get.dart';

class Dimensions{
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //Dynamic for widget
  static double pageView = screenHeight/2.72;
  static double pageViewContainer = screenHeight/3.95;
  static double pageViewTextContainer = screenHeight/7.03;

  //Dynamic height padding and margin
  static double height20 = screenHeight/43.43;
  static double height45 = screenHeight/19.31;
  static double height100 = screenHeight/8.69;


  //Dynamic width padding and margin
  static double width20 = screenWidth/20.55;
  static double width45 = screenWidth/9.13;
  static double width100 = screenWidth/4.11;

  //Dynamic for fonts
  static double font12 = screenHeight/62.2;
  static double font20 = screenHeight/43.43;
  static double font26 = screenHeight/33.41;

  //Dynamic for radius
  static double radius5 = screenHeight/173.8;
  static double radius15 = screenHeight/57.90;
  static double radius20 = screenHeight/43.43;
  static double radius30 = screenHeight/28.97;

  //Icon size
  static double iconSize24 = screenHeight/36.21;
  static double iconSize16 = screenHeight/54.28;
  static double iconSize15 = screenHeight/57.90;

  //Splash Page
  static double splashImg = screenWidth/2;

}