import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../config/theme.dart';
import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Obx(
            () => TextField(
              controller: controller.currentPassCtrl,
              autocorrect: false,
              obscureText: controller.isHiding1.value ? true : false,
              decoration: InputDecoration(
                hintText: 'Password Lama',
                contentPadding: EdgeInsets.all(16),
                hintStyle: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
                fillColor: CustomColor.lightGrey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    controller.isHiding1.value = !controller.isHiding1.value;
                  },
                  child: Icon(
                    controller.isHiding1.value ? IconlyLight.hide : IconlyLight.show,
                    color: CustomColor.grey,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Obx(
            () => TextField(
              controller: controller.newPassCtrl,
              autocorrect: false,
              obscureText: controller.isHiding2.value ? true : false,
              decoration: InputDecoration(
                hintText: 'Password Baru',
                contentPadding: EdgeInsets.all(16),
                hintStyle: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
                fillColor: CustomColor.lightGrey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    controller.isHiding2.value = !controller.isHiding2.value;
                  },
                  child: Icon(
                    controller.isHiding2.value ? IconlyLight.hide : IconlyLight.show,
                    color: CustomColor.grey,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Obx(
            () => TextField(
              controller: controller.confirmPassCtrl,
              autocorrect: false,
              obscureText: controller.isHiding3.value ? true : false,
              decoration: InputDecoration(
                hintText: 'Konfirmasi Password Baru',
                contentPadding: EdgeInsets.all(16),
                hintStyle: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
                fillColor: CustomColor.lightGrey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    controller.isHiding3.value = !controller.isHiding3.value;
                  },
                  child: Icon(
                    controller.isHiding3.value ? IconlyLight.hide : IconlyLight.show,
                    color: CustomColor.grey,
                  ),
                ),
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
                  backgroundColor: CustomColor.primary,
                ),
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    controller.ubahPassword();
                  }
                },
                child: Text(
                  controller.isLoading.isFalse ? 'Ubah Password' : 'Loading...',
                  style: Theme.of(context).textTheme.button?.copyWith(color: CustomColor.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
