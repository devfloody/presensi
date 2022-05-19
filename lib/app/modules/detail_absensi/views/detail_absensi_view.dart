import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/config/theme.dart';

import '../controllers/detail_absensi_controller.dart';

class DetailAbsensiView extends GetView<DetailAbsensiController> {
  final Map<String, dynamic> absensi = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Absensi'),
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
                          absensi['praktikum'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: CustomColor.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${absensi['hari']}, ${absensi['tanggal']} - ${absensi['jam_masuk']}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: CustomColor.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Kelas : ${absensi['kelas']}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: CustomColor.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dosen : ${absensi['dosen']}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.white,
                      ),
                    ),
                    Text(
                      "Jumlah Praktikan Hadir : ${absensi['jumlah_hadir']} Orang",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.white,
                      ),
                    ),
                    Text(
                      "Jumlah Praktikan Tidak Hadir : ${absensi['jumlah_tidak_hadir']} Orang",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Materi :",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: CustomColor.white,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColor.white,
                  ),
                  child: Text(
                    "${absensi['materi']}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: CustomColor.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
