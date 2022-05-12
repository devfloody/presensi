import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:presensi/app/widgets/custom_toast.dart';

class AddJadwalController extends GetxController {
  TextEditingController praktCtrl = TextEditingController();
  TextEditingController kodeCtrl = TextEditingController();
  TextEditingController kelasCtrl = TextEditingController();
  TextEditingController hariCtrl = TextEditingController();
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
        hariCtrl.text.isNotEmpty &&
        dosenCtrl.text.isNotEmpty &&
        ruangCtrl.text.isNotEmpty &&
        jmlmhsCtrl.text.isNotEmpty) {
      isLoading.value = true;
      String uid = await auth.currentUser!.uid;
      String jadwalId = '${kodeCtrl.text}-${kelasCtrl.text}';

      try {
        isLoading.value = false;
        await db.collection('pengguna').doc(uid).collection('jadwal').doc(jadwalId).set({
          'praktikum': praktCtrl.text.trim(),
          'kode': jadwalId.toUpperCase().trim(),
          'kelas': kelasCtrl.text.toUpperCase().trim(),
          'hari': hariCtrl.text.trim(),
          'dosen': dosenCtrl.text.trim(),
          'ruang': ruangCtrl.text.trim(),
          'jml_mhs': int.parse(jmlmhsCtrl.text.trim()),
        });
        Get.back();
        CustomToast.successToast('Berhasil', 'Jadwal berhasil ditambahkan');
      } catch (e) {
        isLoading.value = false;
        CustomToast.errorToast('Terjadi Kesalahan', 'Gagal menambahkan jadwal');
      }
    } else {
      CustomToast.warningToast('Terjadi Kesalahan', 'Semua data harus diisi terlebih dahulu');
    }
  }
}
