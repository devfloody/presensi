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
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sistem Absensi\nLab. Teknik Elektro',
                    style:
                        Theme.of(context).textTheme.headline1!.copyWith(color: CustomColor.white),
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
                    style:
                        Theme.of(context).textTheme.headline4!.copyWith(color: CustomColor.white),
                  ),
                ],
              ),
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
