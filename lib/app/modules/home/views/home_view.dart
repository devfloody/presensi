import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../config/theme.dart';
import '../../../controllers/main_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_toast.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final mainCtrl = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('in_ID', 'Indonesia');
    String hari = DateFormat('EEEE, d MMMM yyyy', 'in_ID').format(DateTime.now()).split(',').first;
    mainCtrl.currentIndex.value = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beranda',
          style: TextStyle(color: CustomColor.black),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset('assets/images/mini-icon.png'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.logout(),
            icon: Icon(
              IconlyBold.logout,
              color: CustomColor.error,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CustomColor.lightGrey),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData) {
                Map<String, dynamic> user = snapshot.data!.data()!;
                String defaultImage = 'https://ui-avatars.com/api/?name=${user['name']}&background=FFAF5A';

                return InkWell(
                  onTap: () {
                    Get.offAllNamed(Routes.PROFILE);
                    mainCtrl.currentIndex.value = 3;
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
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
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Get.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello,',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: CustomColor.white,
                                    ),
                                  ),
                                  Text(
                                    '${user['name']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: CustomColor.white,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '${user['nim']}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: CustomColor.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: ClipOval(
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  child: Image.network(
                                    user['photoURL'] != null ? user['photoURL'] : defaultImage,
                                    fit: BoxFit.cover,
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
              }
              return Text('Tidak dapat memuat data');
            },
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jadwal Praktikum',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(Routes.JADWAL);
                  mainCtrl.currentIndex.value = 2;
                },
                child: Text('Lihat Semua'),
              ),
            ],
          ),
          SizedBox(height: 12),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.jadwalStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CustomColor.lightGrey),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData) {
                final data = snapshot.requireData;
                if (data.size == 0) {
                  return Center(
                    child: Text(
                      'Belum ada jadwal praktikum.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.black,
                      ),
                    ),
                  );
                }
                return SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      Map<String, dynamic> jadwalList = snapshot.data!.docs[index].data();
                      String kode = 'Unknown';
                      return Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.all(16),
                        width: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: CustomColor.white,
                          border: Border.all(
                            color: CustomColor.lightGrey,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: CustomColor.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      jadwalList['kelas'],
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w500,
                                        color: CustomColor.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  jadwalList['praktikum'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hari : ${jadwalList['hari']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColor.grey,
                                  ),
                                ),
                                Text(
                                  'Ruang : ${jadwalList['ruang']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColor.grey,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Container(
                                  height: 40,
                                  width: 100,
                                  child: TextButton(
                                    onPressed: () async {
                                      try {
                                        kode = await FlutterBarcodeScanner.scanBarcode(
                                            '#34CA74', 'Batal', true, ScanMode.QR);
                                        if (kode == jadwalList['kode']) {
                                          if (jadwalList['hari'] == hari) {
                                            Get.toNamed(Routes.ABSEN, arguments: jadwalList);
                                            CustomToast.successToast(
                                              'Kode kelas sudah sesuai : ${jadwalList['kode']}',
                                            );
                                          } else {
                                            CustomToast.warningToast(
                                              'Anda tidak dapat absen karena hari tidak sesuai dengan jadwal',
                                            );
                                          }
                                        } else {
                                          CustomToast.errorToast(
                                            'Kode praktikum tidak dikenali',
                                          );
                                        }
                                      } on PlatformException {
                                        print('Failed to get platform version.');
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: CustomColor.black,
                                      backgroundColor: CustomColor.secondary,
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          IconlyBold.scan,
                                          size: 22,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Hadiri',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: data.docs.length < 5 ? data.docs.length : 5,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                  ),
                );
              } else {
                return Center(
                  child: Text('Belum ada data jadwal.'),
                );
              }
            },
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Riwayat Praktikum',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(Routes.RIWAYAT);
                  mainCtrl.currentIndex.value = 1;
                },
                child: Text('Lihat Semua'),
              ),
            ],
          ),
          SizedBox(height: 12),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.absenStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CustomColor.lightGrey),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData) {
                final data = snapshot.requireData;
                if (data.size == 0) {
                  return Center(
                    child: Text(
                      'Belum ada riwayat pelaksanaan praktikum.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.black,
                      ),
                    ),
                  );
                }
                return SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      Map<String, dynamic> absenList = snapshot.data!.docs[index].data();
                      return InkWell(
                        onTap: () => Get.toNamed(Routes.DETAIL_ABSENSI, arguments: absenList),
                        child: Container(
                          margin: EdgeInsets.only(right: 12),
                          padding: EdgeInsets.all(16),
                          width: 210,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: CustomColor.white,
                            border: Border.all(
                              color: CustomColor.lightGrey,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${absenList['hari']}, ${absenList['tanggal']}, ${absenList['jam_masuk']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColor.black,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Container(
                                    height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: CustomColor.lightGrey,
                                    ),
                                    child: Center(
                                      child: Text(
                                        absenList['kelas'],
                                        style: TextStyle(
                                          fontSize: 48,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColor.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 40,
                                child: Text(
                                  absenList['praktikum'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.black,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Praktikan hadir : ${absenList['jumlah_hadir']} orang',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: CustomColor.black,
                                    ),
                                  ),
                                  Text(
                                    'Praktikan tidak hadir : ${absenList['jumlah_tidak_hadir']} orang',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: CustomColor.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: data.docs.length < 5 ? data.docs.length : 5,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                  ),
                );
              }
              return Center(
                child: Text('Belum ada data jadwal.'),
              );
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
