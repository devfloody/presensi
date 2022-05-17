import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/widgets/custom_toast.dart';

import '../../../config/theme.dart';
import '../controllers/add_jadwal_controller.dart';

class AddJadwalView extends GetView<AddJadwalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Jadwal'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        physics: BouncingScrollPhysics(),
        children: [
          DropdownButtonFormField<String>(
            value: controller.selectedPraktikum.value,
            items: controller.daftarPraktikum
                .map(
                  (item) => DropdownMenuItem<String>(
                    child: Text(item.toString()),
                    value: item.toString(),
                  ),
                )
                .toList(),
            decoration: InputDecoration(
              labelText: 'Nama Praktikum',
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
              controller.selectedPraktikum.value = value.toString();
              CustomToast.successToast('Praktikum : ${controller.selectedPraktikum.value}');
            },
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: controller.selectedKode.value,
            items: controller.daftarKode
                .map(
                  (item) => DropdownMenuItem<String>(
                    child: Text(item.toString()),
                    value: item.toString(),
                  ),
                )
                .toList(),
            decoration: InputDecoration(
              labelText: 'Kode Praktikum',
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
              controller.selectedKode.value = value.toString();
              CustomToast.successToast('Kode Praktikum : ${controller.selectedKode.value}');
            },
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: controller.selectedKelas.value,
            items: controller.daftarKelas
                .map(
                  (item) => DropdownMenuItem<String>(
                    child: Text(item.toString()),
                    value: item.toString(),
                  ),
                )
                .toList(),
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
            onChanged: (value) {
              controller.selectedKelas.value = value.toString();
              CustomToast.successToast('Kelas : ${controller.selectedKelas.value}');
            },
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: controller.selectedDosen.value,
            items: controller.daftarDosen
                .map(
                  (item) => DropdownMenuItem<String>(
                    child: Text(item.toString()),
                    value: item.toString(),
                  ),
                )
                .toList(),
            decoration: InputDecoration(
              labelText: 'Dosen Pengampu',
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
              controller.selectedDosen.value = value.toString();
              CustomToast.successToast('Dosen Pengampu : ${controller.selectedDosen.value}');
            },
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: controller.selectedRuang.value,
            items: controller.daftarRuang
                .map(
                  (item) => DropdownMenuItem<String>(
                    child: Text(item.toString()),
                    value: item.toString(),
                  ),
                )
                .toList(),
            decoration: InputDecoration(
              labelText: 'Ruang Praktikum',
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
              controller.selectedRuang.value = value.toString();
              CustomToast.successToast('Ruang : ${controller.selectedRuang.value}');
            },
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
              CustomToast.successToast('Hari : ${controller.selectedHari.value}');
            },
          ),
          SizedBox(height: 16),
          TextField(
            controller: controller.jmlmhsCtrl,
            decoration: InputDecoration(
              labelText: 'Jumlah Mahasiswa',
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
                  backgroundColor: CustomColor.primary,
                ),
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.addJadwal();
                  }
                },
                child: Text(
                  controller.isLoading.isFalse ? 'Tambah Jadwal Praktikum' : 'Loading...',
                  style: Theme.of(context).textTheme.button?.copyWith(color: CustomColor.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Text(
              '* Pastikan data yang anda masukkan sudah benar.',
              style: TextStyle(
                color: CustomColor.error,
                fontSize: 12,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
