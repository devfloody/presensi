import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../config/theme.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/hero_image.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(20),
            physics: BouncingScrollPhysics(),
            children: [
              HeroImage(image: 'assets/svg/auth2.svg'),
              SignUpScreenTitle(),
              SizedBox(height: 20),
              TextFormField(
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
              SizedBox(height: 16),
              TextFormField(
                controller: controller.nimCtrl,
                decoration: InputDecoration(
                  hintText: 'NIM',
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
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,63})$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                controller: controller.emailCtrl,
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
              Obx(
                () => TextFormField(
                  controller: controller.passCtrl,
                  obscureText: controller.isHiding.value ? true : false,
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                        controller.isHiding.value = !controller.isHiding.value;
                      },
                      child: Icon(
                        controller.isHiding.value ? IconlyLight.hide : IconlyLight.show,
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
                      if (controller.isLoading.isFalse && _formKey.currentState!.validate()) {
                        controller.signUp();
                      }
                    },
                    child: Text(
                      controller.isLoading.isFalse ? 'Daftar' : 'Loading...',
                      style: Theme.of(context).textTheme.button?.copyWith(color: CustomColor.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Obx(
                () => CheckboxListTile(
                  value: controller.isAgree.value,
                  onChanged: (value) {
                    controller.agreeToggle(value);
                    print(value);
                  },
                  activeColor: CustomColor.success,
                  contentPadding: EdgeInsets.all(0),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Setuju dengan syarat dan ketentuan.',
                        style: Theme.of(context).textTheme.headline5?.copyWith(color: CustomColor.grey),
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.EULA),
                        child: Text(
                          'Baca syarat dan ketentuan',
                          style: Theme.of(context).textTheme.headline5?.copyWith(color: CustomColor.secondary),
                        ),
                      ),
                    ],
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpScreenTitle extends StatelessWidget {
  const SignUpScreenTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buat akun baru',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: CustomColor.black,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: 'Sudah punya akun? ',
            style: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
          ),
          TextSpan(
            text: 'Masuk',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w600, color: CustomColor.primary),
            recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(Routes.LOGIN),
          ),
        ])),
      ],
    );
  }
}
