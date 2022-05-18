import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/controllers/main_controller.dart';
import 'package:presensi/app/routes/app_pages.dart';

import '../../../config/theme.dart';
import '../controllers/absen_controller.dart';

class AbsenView extends GetView<AbsenController> {
  final Map<String, dynamic> jadwalList = Get.arguments;
  final mainCtrl = Get.find<MainController>();

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
              labelText: 'Kode Kelas',
              contentPadding: EdgeInsets.all(16),
              labelStyle: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
              fillColor: CustomColor.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: CustomColor.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: controller.hadirCtrl,
            decoration: InputDecoration(
              labelText: 'Jumlah Mahasiswa Hadir',
              contentPadding: EdgeInsets.all(16),
              labelStyle: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
              fillColor: CustomColor.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: CustomColor.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: controller.materiCtrl,
            minLines: 3,
            maxLines: 5,
            maxLength: 500,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: 'Materi Ajar',
              contentPadding: EdgeInsets.all(16),
              labelStyle: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
              fillColor: CustomColor.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: CustomColor.grey,
                ),
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
                    Get.offAllNamed(Routes.RIWAYAT);
                    mainCtrl.currentIndex.value = 1;
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
