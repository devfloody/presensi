import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:presensi/app/widgets/custom_toast.dart';

class AddJadwalController extends GetxController {
  TextEditingController jmlmhsCtrl = TextEditingController();

  RxBool isLoading = false.obs;
  RxString selectedPraktikum = "Dasar Teknik Digital".obs;
  RxString selectedKode = "DTD".obs;
  RxString selectedKelas = "A".obs;
  RxString selectedDosen = "Pratomo Budi Santoso, S.T., M.T".obs;
  RxString selectedHari = "Senin".obs;
  RxString selectedRuang = "Komputer".obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = await auth.currentUser!.uid;
    yield* db.collection('pengguna').doc(uid).snapshots();
  }

  Future<void> addJadwal(String nama) async {
    if (selectedPraktikum.value.isNotEmpty &&
        selectedKode.value.isNotEmpty &&
        selectedKelas.value.isNotEmpty &&
        selectedDosen.value.isNotEmpty &&
        selectedRuang.value.isNotEmpty &&
        selectedHari.value.isNotEmpty &&
        jmlmhsCtrl.text.isNotEmpty) {
      isLoading.value = true;
      String uid = await auth.currentUser!.uid;
      String jadwalId = '${selectedKode.value}-${selectedKelas.value}';

      try {
        isLoading.value = false;
        await db.collection('pengguna').doc(uid).collection('jadwal').doc(jadwalId).set({
          'praktikum': selectedPraktikum.value,
          'asisten': nama,
          'kode': jadwalId.toUpperCase().trim(),
          'kelas': selectedKelas.value,
          'dosen': selectedDosen.value,
          'hari': selectedHari.value,
          'ruang': selectedRuang.value,
          'jml_mhs': int.parse(jmlmhsCtrl.text.trim()),
          'jml_pertemuan': 0,
        });
        Get.back();
        CustomToast.successToast('Jadwal berhasil ditambahkan');
      } catch (e) {
        isLoading.value = false;
        CustomToast.errorToast('Gagal menambahkan jadwal');
      }
    } else {
      CustomToast.warningToast('Semua data harus diisi terlebih dahulu');
    }
  }

  List<String> daftarPraktikum = [
    "Dasar Teknik Digital",
    "Dasar Elektronika",
    "Elektronika Daya",
    "Dasar Teknik Kendali",
    "Teknik Pengendalian Mesin Listrik",
    "Otomasi Industri dan PLC",
    "Programmable Logic Design",
  ];

  List<String> daftarKode = [
    "DTD",
    "DE",
    "ELDA",
    "DTK",
    "TPML",
    "PLC",
    "PLD",
  ];

  List<String> daftarKelas = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
  ];

  List<String> daftarDosen = [
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

  List<String> daftarHari = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
  ];

  List<String> daftarRuang = [
    "Komputer",
    "Elektronika",
    "STL",
  ];
}
