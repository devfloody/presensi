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
            minLines: 1,
            maxLines: 3,
            maxLength: 200,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: 'Materi',
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
          Text(
            'Status Kehadiran Dosen : ',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w500, color: CustomColor.black),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: CustomColor.lightGrey,
              ),
            ),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Switch.adaptive(
                    value: controller.isDosenHadir.value,
                    onChanged: (value) {
                      controller.isDosenHadir.value = value;
                    },
                  ),
                  Text(
                    controller.isDosenHadir.value ? 'Dosen Hadir' : 'Dosen Tidak Hadir',
                    style:
                        Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.black),
                  ),
                ],
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
