import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme.dart';

class TentangView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.2),
              Text(
                'Sistem Absensi\nLab. Teknik Elektro',
                style: Theme.of(context).textTheme.headline1!.copyWith(color: CustomColor.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Container(
                height: 100,
                width: 90,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Digitalisasi sistem absensi di Laboratorium Teknik Elektro UMS dengan menggunakan Teknologi QR Code.',
                style: Theme.of(context).textTheme.headline4!.copyWith(color: CustomColor.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60),
              Text(
                '- Presensi App V1 -',
                style:
                    Theme.of(context).textTheme.headline4!.copyWith(color: CustomColor.secondary),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: CustomColor.secondary,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Kembali',
                    style: Theme.of(context).textTheme.button,
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
