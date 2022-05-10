import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../config/theme.dart';
import '../controllers/absen_controller.dart';

class AbsenView extends GetView<AbsenController> {
  final Map<String, dynamic> jadwalList = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.kodeCtrl.text = jadwalList['kode'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Absen'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: controller.kodeCtrl,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Kode Kelas',
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
            controller: controller.hadirCtrl,
            decoration: InputDecoration(
              hintText: 'Jumlah Mahasiswa Hadir',
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
                    await controller.absen(jadwalList);
                  }
                },
                child: Text(
                  controller.isLoading.isFalse ? 'Absen' : 'Loading...',
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
