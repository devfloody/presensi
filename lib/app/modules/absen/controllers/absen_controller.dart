import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AbsenController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController hadirCtrl = TextEditingController();
  TextEditingController kodeCtrl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> absen(Map<String, dynamic> jadwalList) async {
    if (hadirCtrl.text.isNotEmpty && kodeCtrl.text.isNotEmpty) {
      isLoading.value = true;
      String uid = await auth.currentUser!.uid;
      String tanggal = DateFormat.yMMMMEEEEd().format(DateTime.now());
      String jamMasuk = DateFormat.Hm().format(DateTime.now());
      String absenId = jamMasuk.replaceAll(':', '-').split(' ').first;

      try {
        isLoading.value = false;
        await db.collection('pengguna').doc(uid).collection('data_absen').doc(absenId).set({
          'kode': jadwalList['kode'],
          'tanggal': '$tanggal - $jamMasuk',
          'jam_masuk': jamMasuk,
          'jumlah_hadir': int.parse(hadirCtrl.text),
          'jumlah_tidak_hadir': jadwalList['jml_mhs'] - int.parse(hadirCtrl.text),
          'dosen': jadwalList['dosen'],
          'ruang': jadwalList['ruang'],
          'praktikum': jadwalList['praktikum'],
          'kelas': jadwalList['kelas'],
        });
        Get.back();
        Get.snackbar('Berhasil', 'Anda berhasil melakukan absensi.');
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Terjadi Kesalahan', 'Tidak dapat melakukan absen.');
      }
    } else {
      isLoading.value = false;
      Get.snackbar('Terjadi Kesalahan', 'Isi terlebih dahulu jumlah mahasiswa yang hadir.');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> jadwalStream() async* {
    String uid = await auth.currentUser!.uid;
    yield* db.collection('pengguna').doc(uid).collection('jadwal').snapshots();
  }
}
