import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_toast.dart';

class SignupController extends GetxController {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController nimornikCtrl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  var isAdmin = false.obs;
  RxBool isLoading = false.obs;
  RxBool isHiding = true.obs;
  RxBool isAgree = false.obs;

  void adminToggle(value) {
    isAdmin.value = !isAdmin.value;
    update();
  }

  void agreeToggle(value) {
    isAgree.value = !isAgree.value;
    update();
  }

  Future<void> signUp() async {
    if (nameCtrl.text.isNotEmpty &&
        emailCtrl.text.isNotEmpty &&
        passCtrl.text.isNotEmpty &&
        nimornikCtrl.text.isNotEmpty) {
      isLoading.value = true;
      if (isAgree.value != false) {
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
                'name': nameCtrl.text.trim(),
                'email': emailCtrl.text.trim(),
                'password': passCtrl.text.trim(),
                'nim_or_nik': nimornikCtrl.text.trim(),
                'uid': uid,
                'role': isAdmin.value ? 'Dosen' : 'Asisten',
                'createdAt': FieldValue.serverTimestamp(),
              },
            );
            await userCredential.user!.sendEmailVerification();
          }
          CustomToast.successToast(
            'Berhasil mendaftarkan akun, silahkan verifikasi email anda.',
          );
          isLoading.value = false;
          Get.offAllNamed(Routes.LOGIN);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            isLoading.value = false;
            CustomToast.warningToast('Password terlalu lemah, ubah password anda.');
          } else if (e.code == 'email-already-in-use') {
            isLoading.value = false;
            CustomToast.warningToast(
              'Email telah terdaftar. Silahkan login atau ganti email anda.',
            );
          }
        } catch (e) {
          isLoading.value = false;
          CustomToast.errorToast('Pendaftaran gagal, silahkan coba lagi.');
        }
      } else {
        isLoading.value = false;
        CustomToast.warningToast(
          'Anda harus menyetujui syarat dan ketentuan terlebih dahulu.',
        );
      }
    } else {
      isLoading.value = false;
      CustomToast.warningToast(
        'Nama, Email, NIM/NIK dan Password harus diisi.',
      );
    }
  }
}
