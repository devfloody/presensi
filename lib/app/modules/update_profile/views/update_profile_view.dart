import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../config/theme.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.emailCtrl.text = user['email'];
    controller.nimCtrl.text = user['nim'];
    controller.nameCtrl.text = user['name'];

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profil'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ubah Foto Profil',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: CustomColor.black, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    GetBuilder<UpdateProfileController>(
                      builder: (ctrl) {
                        if (ctrl.image != null) {
                          return Column(
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Image.file(
                                    File(ctrl.image!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          if (user['photoURL'] != null) {
                            return Column(
                              children: [
                                ClipOval(
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    child: Image.network(
                                      user['photoURL'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                InkWell(
                                  onTap: () => controller.hapusProfil(user['uid']),
                                  child: Text(
                                    'Hapus',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ],
                            );
                          }
                          return Text(
                            'Tidak Ada Foto',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: CustomColor.grey),
                          );
                        }
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        controller.pickImage();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: CustomColor.primary,
                        primary: CustomColor.white,
                      ),
                      child: Text('Pilih file'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.emailCtrl,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Email',
                contentPadding: EdgeInsets.all(16),
                hintStyle: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
                fillColor: CustomColor.lightGrey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.nimCtrl,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'NIM / NIK',
                contentPadding: EdgeInsets.all(16),
                hintStyle: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
                fillColor: CustomColor.lightGrey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.nameCtrl,
              decoration: InputDecoration(
                hintText: 'Nama',
                contentPadding: EdgeInsets.all(16),
                hintStyle: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
                fillColor: CustomColor.lightGrey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 32),
            Obx(
              () => SizedBox(
                height: 50,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: CustomColor.secondary,
                  ),
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.updateProfile(user['uid']);
                    }
                  },
                  child: Text(
                    controller.isLoading.isFalse ? 'Update Profile' : 'Loading...',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
