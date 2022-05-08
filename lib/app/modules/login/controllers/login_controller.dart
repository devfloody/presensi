import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailCtrl.text.trim(),
          password: passCtrl.text.trim(),
        );
        if (userCredential.user != null) {
          Get.offAllNamed(Routes.HOME);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          Get.snackbar('Ubah Password', 'Password salah.');
        } else if (e.code == 'user-not-found') {
          Get.snackbar('Ubah Email', 'Email tidak terdaftar.');
        }
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan', 'Login gagal, silahkan coba lagi.');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Email dan Password harus diisi.');
    }
  }
}
