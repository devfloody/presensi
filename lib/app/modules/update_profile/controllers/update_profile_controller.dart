import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nimCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  RxBool isLoading = false.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> updateProfile(String uid) async {
    if (emailCtrl.text.isNotEmpty && nimCtrl.text.isNotEmpty && nameCtrl.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await db.collection('pengguna').doc(uid).update({'name': nameCtrl.text});
        Get.snackbar('Berhasil', 'Berhasil mengupdate profil');
      } catch (e) {
        Get.snackbar('Gagal', 'Gagal mengupdate profil');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
