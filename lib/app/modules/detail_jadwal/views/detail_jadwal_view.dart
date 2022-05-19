import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/config/theme.dart';

import '../controllers/detail_jadwal_controller.dart';

class DetailJadwalView extends GetView<DetailJadwalController> {
  final Map<String, dynamic> jadwal = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Jadwal'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CustomColor.primary,
              boxShadow: [
                BoxShadow(
                  color: CustomColor.black.withOpacity(0.25),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          jadwal['praktikum'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: CustomColor.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Kelas : ${jadwal['kelas']}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: CustomColor.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Hari : ${jadwal['hari']}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: CustomColor.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dosen Pengampu :  ${jadwal['dosen']}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.white,
                      ),
                    ),
                    Text(
                      "Jumlah Praktikan  :  ${jadwal['jml_mhs']} Mahasiswa",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400, color: CustomColor.white),
                    ),
                    Text(
                      "Ruang Praktikum   :  ${jadwal['ruang']}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Jumlah Pertemuan : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: CustomColor.white,
                          ),
                        ),
                        Text(
                          '${jadwal['jml_pertemuan']} Kali',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: CustomColor.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
