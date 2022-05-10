import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:presensi/app/controllers/main_controller.dart';

import '../../../config/theme.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final mainCtrl = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
        centerTitle: true,
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
                String defaultImage =
                    'https://ui-avatars.com/api/?name=${user['name']}&background=FFAF5A';

                return Container(
                  padding: EdgeInsets.all(16),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CustomColor.lightGrey),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: CustomColor.primary,
                            ),
                          ),
                          Text(
                            '${user['name']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: CustomColor.primary,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '${user['nim_or_nik']}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: CustomColor.black,
                            ),
                          ),
                        ],
                      ),
                      ClipOval(
                        child: Container(
                          height: 80,
                          width: 80,
                          child: Image.network(
                            user['photoURL'] != null ? user['photoURL'] : defaultImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
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
                },
                child: Text('Lihat Semua'),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 280,
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.jadwalStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final jadwal = snapshot.requireData;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.all(16),
                        width: 230,
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
                                  jadwal.docs[index]['praktikum'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.black,
                                  ),
                                ),
                                Text(
                                  'Ruang ${jadwal.docs[index]['ruang']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColor.grey,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: CustomColor.primary,
                              ),
                              child: Center(
                                child: Text(
                                  jadwal.docs[index]['kelas'],
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: CustomColor.secondary,
                                  primary: CustomColor.black,
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Absen',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Icon(
                                      IconlyBold.scan,
                                      size: 22,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: jadwal.docs.length < 5 ? jadwal.docs.length : 5,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                  );
                }
                return Center(
                  child: Text('Tidak ada data'),
                );
              },
            ),
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
                },
                child: Text('Lihat Semua'),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 280,
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.jadwalStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final jadwal = snapshot.requireData;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.all(16),
                        width: 230,
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
                                  jadwal.docs[index]['praktikum'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.black,
                                  ),
                                ),
                                Text(
                                  'Ruang ${jadwal.docs[index]['ruang']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColor.grey,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: CustomColor.lightGrey,
                              ),
                              child: Center(
                                child: Text(
                                  jadwal.docs[index]['kelas'],
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: CustomColor.lightGrey,
                                  primary: CustomColor.black,
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                ),
                                child: Text(
                                  'Selesai',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: jadwal.docs.length < 5 ? jadwal.docs.length : 5,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                  );
                }
                return Center(
                  child: Text('Tidak ada data'),
                );
              },
            ),
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
