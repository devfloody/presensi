import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
          TextField(
            controller: controller.currentPassCtrl,
            autocorrect: false,
            obscureText: true,
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
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: controller.newPassCtrl,
            autocorrect: false,
            obscureText: true,
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
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: controller.confirmPassCtrl,
            autocorrect: false,
            obscureText: true,
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
