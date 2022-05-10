import 'package:get/get.dart';

import '../routes/app_pages.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;

    switch (index) {
      case 1:
        Get.offAllNamed(Routes.RIWAYAT);
        break;
      case 2:
        Get.offAllNamed(Routes.JADWAL);
        break;
      case 3:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }
}
