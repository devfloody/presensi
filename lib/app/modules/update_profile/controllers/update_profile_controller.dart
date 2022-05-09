import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

    if (image != null) {
      print(image!.path);
      print(image!.name.split('.').last);
    } else {
      print('No image selected');
    }
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
        Get.snackbar('Berhasil', 'Berhasil mengupdate profil');
      } catch (e) {
        Get.snackbar('Gagal', 'Gagal mengupdate profil');
      } finally {
        isLoading.value = false;
      }
    }
  }

  void hapusProfil(String uid) async {
    try {
      await db.collection('pengguna').doc(uid).update({'photoURL': FieldValue.delete()});
      Get.back();
      Get.snackbar('Berhasil', 'Berhasil menghapus foto profil');
    } catch (e) {
      Get.snackbar('Gagal', 'Gagal menghapus foto profil');
    } finally {
      update();
    }
  }
}
