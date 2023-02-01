import 'package:get/get.dart';

class HomeController extends GetxController{
  int selectIndex = 0;

  changeSelectIndex(int selectIndex){
    this.selectIndex = selectIndex;
    update();
  }
}
