import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../config/theme.dart';
import '../controllers/edit_jadwal_controller.dart';

class EditJadwalView extends GetView<EditJadwalController> {
  final Map<String, dynamic> jadwal = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.praktCtrl.text = jadwal['praktikum'];
    controller.kelasCtrl.text = jadwal['kelas'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Jadwal'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: controller.praktCtrl,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Praktikum',
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
            controller: controller.kelasCtrl,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Kelas',
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
          DropdownButtonFormField<String>(
            value: controller.selectedHari.value,
            items: controller.daftarHari
                .map(
                  (item) => DropdownMenuItem<String>(
                    child: Text(item.toString()),
                    value: item.toString(),
                  ),
                )
                .toList(),
            decoration: InputDecoration(
              labelText: 'Hari',
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
            onChanged: (value) {
              controller.selectedHari.value = value.toString();
            },
          ),
          SizedBox(height: 32),
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
                    await controller.editJadwal(jadwal['kode']);
                  }
                },
                child: Text(
                  controller.isLoading.isFalse ? 'Ubah Jadwal' : 'Loading...',
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
