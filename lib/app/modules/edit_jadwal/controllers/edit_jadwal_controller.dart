import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_toast.dart';

class EditJadwalController extends GetxController {
  TextEditingController praktCtrl = TextEditingController();
  TextEditingController kelasCtrl = TextEditingController();

  RxString selectedHari = "Senin".obs;
  RxBool isLoading = false.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  List<String> daftarHari = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
  ];

  Future<void> editJadwal(String kode) async {
    if (selectedHari.value.isNotEmpty) {
      isLoading.value = true;
      String uid = await auth.currentUser!.uid;
      try {
        isLoading.value = false;
        await db.collection('pengguna').doc(uid).collection('jadwal').doc(kode).update({
          'hari': selectedHari.value,
        });
        Get.back();
        CustomToast.successToast('Jadwal berhasil diubah ke hari ${selectedHari.value}');
      } catch (e) {
        isLoading.value = false;
        CustomToast.errorToast('Perubahan jadwal tidak dapat dilakukan.');
      }
    } else {
      CustomToast.warningToast('Data tidak ditemukan');
    }
  }
}
