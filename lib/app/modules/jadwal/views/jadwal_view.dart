import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:presensi/app/routes/app_pages.dart';

import '../../../config/theme.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/custom_toast.dart';
import '../controllers/jadwal_controller.dart';

class JadwalView extends GetView<JadwalController> {
  final mainCtrl = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('in_ID', 'Indonesia');
    String hari = DateFormat('EEEE, d MMMM yyyy', 'in_ID').format(DateTime.now()).split(',').first;

    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: CustomColor.secondary,
              ),
              onPressed: () => Get.toNamed(Routes.ADD_JADWAL),
              child: Text(
                '+ Tambah Jadwal',
                style: Theme.of(context).textTheme.button?.copyWith(color: CustomColor.black),
              ),
            ),
          ),
          SizedBox(height: 24),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.jadwalStream(),
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
                      'Belum ada jadwal praktikum, tambahkan jadwal terlebih dahulu.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: data.docs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> jadwalList = snapshot.data!.docs[index].data();
                    String kode = 'Unknown';
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(16),
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: CustomColor.lightGrey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jadwalList['hari'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: CustomColor.secondary,
                                    ),
                                  ),
                                  Text(
                                    'Prakt. ${jadwalList['praktikum']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: CustomColor.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text('Kode : ${jadwalList['kode']}'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dosen : ${jadwalList['dosen']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: CustomColor.black,
                                    ),
                                  ),
                                  Text(
                                    'Ruang : ${jadwalList['ruang']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: CustomColor.black,
                                    ),
                                  ),
                                  Text(
                                    'Praktikan : ${jadwalList['jml_mhs']} mahasiswa',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: CustomColor.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    jadwalList['kelas'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 28,
                                      color: CustomColor.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: CustomColor.error,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () => controller.hapusJadwal(jadwalList['kode']),
                                    icon: Icon(
                                      IconlyBold.delete,
                                      size: 28,
                                      color: CustomColor.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: CustomColor.secondary,
                                ),
                                child: Center(
                                  child: IconButton(
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
                                    icon: Icon(
                                      IconlyLight.scan,
                                      size: 28,
                                      color: CustomColor.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  child: Center(
                    child: Text('Belum ada data jadwal.'),
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
              icon: Icon(IconlyLight.graph),
              label: 'Riwayat',
              selectedIcon: Icon(IconlyBold.graph),
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
