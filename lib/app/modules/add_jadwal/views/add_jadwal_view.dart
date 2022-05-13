import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
          TextField(
            controller: controller.praktCtrl,
            decoration: InputDecoration(
              hintText: 'Nama Praktikum',
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
            controller: controller.kodeCtrl,
            decoration: InputDecoration(
              hintText: 'Kode Praktikum',
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
            controller: controller.kelasCtrl,
            decoration: InputDecoration(
              hintText: 'Kelas',
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
            controller: controller.hariCtrl,
            decoration: InputDecoration(
              hintText: 'Hari',
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
          DropdownSearch<String>(
            mode: Mode.MENU,
            items: controller.daftarDosen,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            dropdownSearchDecoration: InputDecoration(
              hintText: 'Dosen Pengampu',
              contentPadding: EdgeInsets.all(16),
              hintStyle: Theme.of(context).textTheme.headline5!.copyWith(color: CustomColor.grey),
              fillColor: CustomColor.lightGrey,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
            selectedItem: controller.initial.value,
            onChanged: (value) {
              controller.changeItem(value);
            },
          ),
          SizedBox(height: 16),
          TextField(
            controller: controller.ruangCtrl,
            decoration: InputDecoration(
              hintText: 'Ruang Praktikum',
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
            controller: controller.jmlmhsCtrl,
            decoration: InputDecoration(
              hintText: 'Jumlah Mahasiswa',
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
              'Catatan : Pastikan data yang anda masukan sudah sesuai dengan data sebenarnya.',
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
