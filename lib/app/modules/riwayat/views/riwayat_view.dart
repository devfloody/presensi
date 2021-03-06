import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:presensi/app/routes/app_pages.dart';

import '../../../config/theme.dart';
import '../../../controllers/main_controller.dart';
import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  final mainCtrl = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    mainCtrl.currentIndex.value = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Praktikum'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.absenStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                final data = snapshot.requireData;
                if (data.size == 0) {
                  return Center(
                    child: Text(
                      'Belum ada data absen.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.black,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: data.docs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> absenList = snapshot.data!.docs[index].data();
                    return InkWell(
                      onTap: () => Get.toNamed(Routes.DETAIL_ABSENSI, arguments: absenList),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(16),
                        height: Get.height * 0.24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: CustomColor.lightGrey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Prakt. ${absenList['praktikum']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColor.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "${absenList['hari']}, ${absenList['tanggal']}, Pukul ${absenList['jam_masuk']}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColor.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kehadiran Mahasiswa :',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColor.black,
                                        ),
                                      ),
                                      Text(
                                        '- Hadir : ${absenList['jumlah_hadir']} Mahasiswa',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColor.success,
                                        ),
                                      ),
                                      Text(
                                        '- Tidak Hadir : ${absenList['jumlah_tidak_hadir']} Mahasiswa',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColor.error,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: CustomColor.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      absenList['kelas'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 28,
                                        color: CustomColor.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CustomColor.lightGrey),
                  ),
                  child: Center(
                    child: Text('Belum ada data absen.'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: CustomColor.primary,
          height: 70,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: CustomColor.white,
            ),
          ),
          indicatorColor: CustomColor.white,
          iconTheme: MaterialStateProperty.all(
            IconThemeData(
              color: CustomColor.secondary,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: mainCtrl.currentIndex.value,
          animationDuration: Duration(seconds: 8),
          onDestinationSelected: (int i) => mainCtrl.changePage(i),
          destinations: [
            NavigationDestination(
              icon: Icon(IconlyLight.home),
              label: 'Beranda',
              selectedIcon: Icon(IconlyBold.home),
            ),
            NavigationDestination(
              icon: Icon(IconlyLight.time_circle),
              label: 'Riwayat',
              selectedIcon: Icon(IconlyBold.time_circle),
            ),
            NavigationDestination(
              icon: Icon(IconlyLight.calendar),
              label: 'Jadwal',
              selectedIcon: Icon(IconlyBold.calendar),
            ),
            NavigationDestination(
              icon: Icon(IconlyLight.profile),
              label: 'Profil',
              selectedIcon: Icon(IconlyBold.profile),
            ),
          ],
        ),
      ),
    );
  }
}
