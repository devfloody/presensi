import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 1:
        Get.offAllNamed(Routes.RIWAYAT);
        break;
      case 2:
        Get.offAllNamed(Routes.JADWAL);
        break;
      case 3:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> jadwalStream() async* {
    String uid = await auth.currentUser!.uid;
    yield* db.collection('pengguna').doc(uid).collection('jadwal').snapshots();
  }

  String kode = 'Unknown';
  Future absen() async {
    try {
      kode = await FlutterBarcodeScanner.scanBarcode('#34CA74', 'Batal', true, ScanMode.QR);
      print(kode);
    } on PlatformException {
      print('Failed to get platform version.');
    }
  }
}
