import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../config/theme.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.emailCtrl.text = user['email'];
    controller.nimCtrl.text = user['nim_or_nik'];
    controller.nameCtrl.text = user['name'];

    return Scaffold(
        appBar: AppBar(
          title: Text('Update Profil'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
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
            SizedBox(height: 24),
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
