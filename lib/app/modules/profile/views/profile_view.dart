import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:presensi/app/routes/app_pages.dart';

import '../../../config/theme.dart';
import '../../../controllers/main_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final mainCtrl = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;
            print(user);

            return ListView(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              children: [
                Center(
                  child: ClipOval(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        'https://ui-avatars.com/api/?name=${user['name']}&background=FFAF5A',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '${user['name']}',
                  style: Theme.of(context).textTheme.headline2!.copyWith(color: CustomColor.black),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${user['role']} - ${user['nim_or_nik']}',
                  style: Theme.of(context).textTheme.headline4!.copyWith(color: CustomColor.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                ListTile(
                  onTap: () => Get.toNamed(Routes.UPDATE_PROFILE),
                  leading: Icon(IconlyBold.profile),
                  title: Text('Update Profil'),
                  iconColor: Color.fromARGB(255, 57, 57, 57),
                  tileColor: CustomColor.lightGrey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                ListTile(
                  onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                  leading: Icon(IconlyBold.profile),
                  title: Text('Update Password'),
                  iconColor: CustomColor.black,
                  tileColor: CustomColor.lightGrey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(height: 12),
                ListTile(
                  onTap: () => Get.toNamed(Routes.TENTANG),
                  leading: Icon(IconlyBold.info_circle),
                  title: Text('Tentang Aplikasi'),
                  iconColor: CustomColor.black,
                  tileColor: CustomColor.lightGrey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(height: 12),
                ListTile(
                  onTap: () {
                    controller.logout();
                  },
                  leading: Icon(IconlyBold.logout),
                  title: Text('Keluar'),
                  iconColor: CustomColor.black,
                  tileColor: CustomColor.lightGrey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Data tidak ditemukan'),
            );
          }
        },
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
