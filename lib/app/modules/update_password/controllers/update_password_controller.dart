import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:presensi/app/widgets/custom_toast.dart';

class UpdatePasswordController extends GetxController {
  TextEditingController currentPassCtrl = TextEditingController();
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isHiding = true.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void ubahPassword() async {
    if (currentPassCtrl.text.isNotEmpty &&
        newPassCtrl.text.isNotEmpty &&
        confirmPassCtrl.text.isNotEmpty) {
      if (newPassCtrl.text == confirmPassCtrl.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;
          String uid = auth.currentUser!.uid;
          await auth.signInWithEmailAndPassword(
            email: emailUser,
            password: currentPassCtrl.text.trim(),
          );
          await auth.currentUser!.updatePassword(newPassCtrl.text.trim());
          await db.collection('pengguna').doc(uid).update({
            'password': newPassCtrl.text.trim(),
          });
          Get.back();
          CustomToast.successToast(
              'Berhasil', 'Password berhasil diperbarui, silahkan login ulang.');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            CustomToast.warningToast('Terjadi Kesalahan', 'Password lama salah.');
          } else {
            CustomToast.errorToast('Terjadi Kesalahan', '${e.code.toLowerCase()}');
          }
        } catch (e) {
          CustomToast.errorToast('Terjadi Kesalahan', 'Tidak dapat mengubah password.');
        }
      } else {
        CustomToast.warningToast('Terjadi Kesalahan', 'Password baru tidak sama.');
      }
    } else {
      CustomToast.warningToast(
          'Terjadi Kesalahan', 'Isi password lama dan baru anda terlebih dahulu.');
    }
  }
}
