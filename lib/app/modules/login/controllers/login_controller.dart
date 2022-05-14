import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:presensi/app/widgets/custom_dialog.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_toast.dart';

class LoginController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isHiding = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailCtrl.text.trim(),
          password: passCtrl.text.trim(),
        );

        if (userCredential.user != null) {
          print(userCredential);

          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            Get.offAllNamed(Routes.HOME);
          } else {
            CustomAlertDialog.appAlert(
              title: 'Email belum diverifikasi',
              message: 'Cek email anda untuk melihat email verifikasi.',
              onConfirm: () async {
                try {
                  await userCredential.user!.sendEmailVerification();
                  Get.back();
                  CustomToast.successToast(
                    "Email verifikasi telah dikirimkan ke email anda.",
                  );
                  isLoading.value = false;
                } catch (e) {
                  CustomToast.errorToast(
                    "Tidak dapat mengirim email verifikasi. Penyebab : ${e.toString()}",
                  );
                }
              },
              onCancel: () => Get.back(),
            );
            isLoading.value = false;
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          isLoading.value = false;
          CustomToast.warningToast('Password yang anda masukkan salah, periksa kembali password anda.');
        } else if (e.code == 'user-not-found') {
          isLoading.value = false;
          CustomToast.warningToast('Email tidak terdaftar, periksa kembali email anda.');
        }
      } catch (e) {
        CustomToast.errorToast('Login gagal, silahkan coba lagi.');
      }
    } else {
      isLoading.value = false;
      CustomToast.warningToast('Email dan password tidak boleh kosong.');
    }
  }
}
