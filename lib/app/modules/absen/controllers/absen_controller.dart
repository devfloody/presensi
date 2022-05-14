import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:presensi/app/widgets/custom_toast.dart';

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
      initializeDateFormatting('in_ID', 'Indonesia');
      String hari =
          DateFormat('EEEE, d MMMM yyyy', 'in_ID').format(DateTime.now()).split(',').first;
      String tanggal = DateFormat('EEEE, d MMMM yyyy', 'in_ID').format(DateTime.now());
      String jamMasuk = DateFormat.Hm().format(DateTime.now());
      String absenId = '$jamMasuk-$hari';

      try {
        isLoading.value = false;
        await db.collection('pengguna').doc(uid).collection('data-absen').doc(absenId).set({
          'kode': jadwalList['kode'],
          'tanggal': '$tanggal - $jamMasuk WIB',
          'jam_masuk': '$jamMasuk WIB',
          'jumlah_hadir': int.parse(hadirCtrl.text),
          'jumlah_tidak_hadir': jadwalList['jml_mhs'] - int.parse(hadirCtrl.text),
          'dosen': jadwalList['dosen'],
          'ruang': jadwalList['ruang'],
          'praktikum': jadwalList['praktikum'],
          'kelas': jadwalList['kelas'],
        });
        Get.back();
        CustomToast.successToast('Anda berhasil melakukan absensi.');
      } catch (e) {
        isLoading.value = false;
        CustomToast.errorToast('Tidak dapat melakukan absen.');
      }
    } else {
      isLoading.value = false;
      CustomToast.warningToast('Isi terlebih dahulu jumlah mahasiswa yang hadir.');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> jadwalStream() async* {
    String uid = await auth.currentUser!.uid;
    yield* db.collection('pengguna').doc(uid).collection('jadwal').snapshots();
  }
}
