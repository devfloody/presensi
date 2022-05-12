import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../config/theme.dart';
import '../controllers/lupa_password_controller.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lupa Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(
              'assets/svg/forgot_password.svg',
              height: 180,
            ),
          ),
          SizedBox(height: 24),
          LupaPasswordTitle(),
          SizedBox(height: 24),
          TextField(
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
          SizedBox(height: 24),
          Obx(
            () => SizedBox(
              height: 50,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: CustomColor.secondary,
                ),
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.lupaPassword();
                  }
                },
                child: Text(
                  controller.isLoading.isFalse ? 'Kirim Email Reset Password' : 'Loading...',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LupaPasswordTitle extends StatelessWidget {
  const LupaPasswordTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reset Password',
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
          'Kami akan mengirimkan anda email untuk mereset password anda',
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
