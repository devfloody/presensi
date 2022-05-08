import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LupaPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailCtrl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void lupaPassword() async {
    if (emailCtrl.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailCtrl.text);
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan', 'Tidak dapat mengirim email reset password');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
