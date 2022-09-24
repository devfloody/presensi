import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../data/absen_gsheet_api/absen_gsheet_api.dart';
import '../../../models/gsheet_field/rekap_field.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_toast.dart';

class AbsenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDosenHadir = false.obs;
  TextEditingController hadirCtrl = TextEditingController();
  TextEditingController kodeCtrl = TextEditingController();
  TextEditingController materiCtrl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> absen(Map<String, dynamic> jadwalList) async {
    if (hadirCtrl.text.isNotEmpty && kodeCtrl.text.isNotEmpty && materiCtrl.text.isNotEmpty) {
      if (int.parse(hadirCtrl.text) >= 0) {
        if (int.parse(hadirCtrl.text) <= jadwalList['jml_mhs']) {
          isLoading.value = true;
          String uid = await auth.currentUser!.uid;
          initializeDateFormatting('in_ID', 'Indonesia');
          String hari = DateFormat('EEEE, d MMMM yyyy', 'in_ID').format(DateTime.now()).split(',').first;
          String tanggal = DateFormat('d-M-y', 'in_ID').format(DateTime.now());
          String jamMasuk = DateFormat.Hm().format(DateTime.now());
          String absenId = '$jamMasuk-$hari-$tanggal';
          int jmlTidakHadir = jadwalList['jml_mhs'] - int.parse(hadirCtrl.text);

          try {
            // Menyimpan Data Presensi Ke Firestore
            await db.collection('pengguna').doc(uid).collection('data-absen').doc(absenId).set({
              'asisten': jadwalList['asisten'],
              'kode': jadwalList['kode'],
              'hari': hari,
              'tanggal': tanggal,
              'status_dosen': isDosenHadir.isFalse ? 'Dosen Tidak Hadir' : 'Dosen Hadir',
              'jam_masuk': '$jamMasuk WIB',
              'jumlah_hadir': int.parse(hadirCtrl.text),
              'jumlah_tidak_hadir': jadwalList['jml_mhs'] - int.parse(hadirCtrl.text),
              'dosen': jadwalList['dosen'],
              'ruang': jadwalList['ruang'],
              'praktikum': jadwalList['praktikum'],
              'kelas': jadwalList['kelas'],
              'materi': materiCtrl.text,
            });
            // Menambah Jumlah Pertemuan pada Detail Jadwal
            await db.collection('pengguna').doc(uid).collection('jadwal').doc(jadwalList['kode']).update({
              'jml_pertemuan': jadwalList['jml_pertemuan'] + 1,
            });
            // Menyimpan Data Presensi Ke Google Sheets
            await AbsenSheetApi.presensiSheet!.values.map.appendRows([
              {
                RekapField.asisten: jadwalList['asisten'],
                RekapField.praktikum: jadwalList['praktikum'],
                RekapField.kode: jadwalList['kode'],
                RekapField.kelas: jadwalList['kelas'],
                RekapField.ruang: jadwalList['ruang'],
                RekapField.dosen: jadwalList['dosen'],
                RekapField.status: isDosenHadir.isFalse ? 'Dosen Tidak Hadir' : 'Dosen Hadir',
                RekapField.hari: hari,
                RekapField.tanggal: tanggal,
                RekapField.jam: '$jamMasuk WIB',
                RekapField.jumlahHadir: hadirCtrl.text,
                RekapField.jumlahTidakHadir: jmlTidakHadir.toString(),
                RekapField.materi: materiCtrl.text,
              }
            ]);
            isLoading.value = false;
            Get.offAllNamed(Routes.RIWAYAT);
            CustomToast.successToast('Anda berhasil melakukan absensi.');
          } catch (e) {
            isLoading.value = false;
            CustomToast.errorToast('Tidak dapat melakukan absen.');
          }
        }
      } else if (int.parse(hadirCtrl.text) > jadwalList['jml_mhs']) {
        CustomToast.warningToast('Jumlah mahasiswa hadir melebihi jumlah mahasiswa yang ada.');
      } else {
        CustomToast.warningToast('Jumlah mahasiswa hadir tidak valid.');
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
