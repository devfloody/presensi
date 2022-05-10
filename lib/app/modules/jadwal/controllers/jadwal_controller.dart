import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class JadwalController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> jadwalStream() async* {
    String uid = await auth.currentUser!.uid;
    yield* db.collection('pengguna').doc(uid).collection('jadwal').snapshots();
  }
}
