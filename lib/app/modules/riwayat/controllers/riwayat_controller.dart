import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RiwayatController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> absenStream() async* {
    String uid = await auth.currentUser!.uid;
    yield* db
        .collection('pengguna')
        .doc(uid)
        .collection('data_absen')
        .orderBy('tanggal')
        .snapshots();
  }
}
