import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddJadwalController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamJadwal() async* {
    yield* firestore.collection('praktikum').orderBy('kode').snapshots();
  }
}
