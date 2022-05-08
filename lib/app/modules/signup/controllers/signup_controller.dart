import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:presensi/app/routes/app_pages.dart';

class SignupController extends GetxController {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController nimornikCtrl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  var isAdmin = false.obs;
  RxBool isLoading = false.obs;

  void adminToggle(value) {
    isAdmin.value = !isAdmin.value;
    update();
  }

  Future<void> signUp() async {
    if (nameCtrl.text.isNotEmpty &&
        emailCtrl.text.isNotEmpty &&
        passCtrl.text.isNotEmpty &&
        nimornikCtrl.text.isNotEmpty) {
          isLoading.value = true;
      try {
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailCtrl.text.trim(),
          password: passCtrl.text.trim(),
        );
        if (userCredential.user != null) {
          isLoading.value = false;
          String uid = userCredential.user!.uid;
          db.collection('pengguna').doc(uid).set(
            {
              'name': nameCtrl.text,
              'email': emailCtrl.text,
              'password': passCtrl.text,
              'nim_or_nik': nimornikCtrl.text,
              'uid': uid,
              'role': isAdmin.value ? 'Dosen' : 'Asisten',
              'createdAt': FieldValue.serverTimestamp(),
            },
          );
          await userCredential.user!.sendEmailVerification();
        }
        Get.snackbar('Pendaftaran Berhasil', 'Silahkan login untuk melanjutkan');
        isLoading.value = false;
        Get.offAllNamed(Routes.LOGIN);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          isLoading.value = false;
          Get.snackbar('Ubah Password', 'Password terlalu lemah.');
        } else if (e.code == 'email-already-in-use') {
          isLoading.value = false;
          Get.snackbar('Ubah Email', 'Email yang anda gunakan telah terdaftar.');
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Terjadi Kesalahan', 'Pendaftaran gagal, silahkan coba lagi.');
      }
    } else {
      isLoading.value = false;
      Get.snackbar('Terjadi Kesalahan', 'Nama, Email, dan Password harus diisi.');
    }
  }
}
