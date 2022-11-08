import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../config/theme.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/hero_image.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
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
              HeroImage(image: 'assets/svg/auth.svg'),
              LoginScreenTitle(),
              SizedBox(height: 20),
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
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Get.toNamed(Routes.LUPA_PASSWORD),
                    child: Text(
                      'Lupa Password?',
                      style: Theme.of(context).textTheme.button!.copyWith(color: CustomColor.secondary),
                    ),
                  ),
                ],
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
                      if (controller.isLoading.isFalse && _formKey.currentState!.validate()) {
                        await controller.login();
                      }
                    },
                    child: Text(
                      controller.isLoading.isFalse ? 'Masuk' : 'Loading...',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Belum punya akun? ',
                        style: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
                      ),
                      TextSpan(
                        text: 'Daftar',
                        recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(Routes.SIGNUP),
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: CustomColor.secondary, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreenTitle extends StatelessWidget {
  const LoginScreenTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selamat Datang',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: CustomColor.black,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Masuk untuk melanjutkan',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: CustomColor.grey,
          ),
        ),
      ],
    );
  }
}
