import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddJadwalController extends GetxController {
  TextEditingController praktCtrl = TextEditingController();
  TextEditingController kodeCtrl = TextEditingController();
  TextEditingController kelasCtrl = TextEditingController();
  TextEditingController dosenCtrl = TextEditingController();
  TextEditingController ruangCtrl = TextEditingController();
  TextEditingController jmlmhsCtrl = TextEditingController();

  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addJadwal() async {
    if (praktCtrl.text.isNotEmpty &&
        kodeCtrl.text.isNotEmpty &&
        kelasCtrl.text.isNotEmpty &&
        dosenCtrl.text.isNotEmpty &&
        ruangCtrl.text.isNotEmpty &&
        jmlmhsCtrl.text.isNotEmpty) {
      isLoading.value = true;
      String uid = await auth.currentUser!.uid;
      String jadwalId = '${kodeCtrl.text}-${kelasCtrl.text}';
      try {
        isLoading.value = false;
        await db.collection('pengguna').doc(uid).collection('jadwal').doc(jadwalId).set({
          'praktikum': praktCtrl.text,
          'kode': jadwalId,
          'kelas': kelasCtrl.text,
          'dosen': dosenCtrl.text,
          'ruang': ruangCtrl.text,
          'jml_mhs': int.parse(jmlmhsCtrl.text),
        });
        Get.back();
        Get.snackbar('Berhasil', 'Jadwal berhasil ditambahkan');
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Terjadi Kesalahan', 'Gagal menambahkan jadwal');
      }
    }
  }
}
