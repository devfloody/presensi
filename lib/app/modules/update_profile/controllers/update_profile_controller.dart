import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/theme.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_toast.dart';

class UpdateProfileController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nimCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  RxBool isLoading = false.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<void> updateProfile(String uid) async {
    if (emailCtrl.text.isNotEmpty && nimCtrl.text.isNotEmpty && nameCtrl.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {'name': nameCtrl.text};
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split('.').last;

          await storage.ref('$uid/profil.$ext').putFile(file);
          String imageUrl = await storage.ref('$uid/profil.$ext').getDownloadURL();

          data.addAll({'photoURL': imageUrl});
        }
        await db.collection('pengguna').doc(uid).update(data);
        Get.back();
        CustomToast.successToast('Perubahan profil berhasil disimpan');
      } catch (e) {
        CustomToast.errorToast('Tidak dapat melakukan perubahan profil');
      } finally {
        isLoading.value = false;
      }
    }
  }

  void hapusProfil(String uid) {
    CustomAlertDialog.appAlert(
      title: 'Hapus Foto Profil',
      message: 'Apakah anda yakin untuk menghapus foto?',
      confirmText: 'Hapus',
      cancelText: 'Batal',
      confirmColor: CustomColor.error,
      onConfirm: () async {
        try {
          await db.collection('pengguna').doc(uid).update({'photoURL': FieldValue.delete()});
          Get.back();
          CustomToast.successToast('Foto profil telah terhapus');
        } catch (e) {
          CustomToast.errorToast('Tidak dapat menghapus foto profil');
        } finally {
          update();
        }
      },
      onCancel: () => Get.back(),
    );
  }
}
