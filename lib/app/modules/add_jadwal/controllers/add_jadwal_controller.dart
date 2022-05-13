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

  List<String> dosen = [
    "Pratomo Budi Santoso, S.T., M.T",
    "Aris Budiman, S.T., M.T",
    "Abdul Basith, Ir. M.T",
    "Hasyim Asy'ari, S.T., M.T",
    "Umar , S.T., M.T",
    "Muhammad Kusban, Dr. S.T., M.T",
    "Fajar Suryawan, S.T., M.Eng.Sc., Ph.D",
    "Agus Ulinuha, Dr. M.T.",
    "Dedi Ary Prasetya, S.T., M.Eng",
    "Tindyo Prasetyo, S.T, M.T",
    "Bambang Hari Purwoto, S.T., M.T",
    "Umi Fadlilah, S.T., M.Eng",
    "Rizki Nurilyas Ahmad, S.T., M.T.",
    "Heru Supriyono, S.T., M.Sc., Ph.D",
  ];
}
