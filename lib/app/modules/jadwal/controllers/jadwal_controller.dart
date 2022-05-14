import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_toast.dart';

class JadwalController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> jadwalStream() async* {
    String uid = await auth.currentUser!.uid;
    yield* db.collection('pengguna').doc(uid).collection('jadwal').snapshots();
  }

  void hapusJadwal(String kode) async {
    String uid = await auth.currentUser!.uid;
    try {
      await db.collection('pengguna').doc(uid).collection('jadwal').doc(kode).delete();
      CustomToast.successToast('Jadwal dengan kode: $kode berhasil dihapus');
    } catch (e) {
      CustomToast.errorToast('Jadwal gagal dihapus dari daftar. Kode error : $e');
    } finally {
      update();
    }
  }
}
