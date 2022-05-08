import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

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
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        children: [
          CircleAvatar(
            backgroundColor: CustomColor.primary,
            radius: 45,
            child: Image.asset('assets/images/avtar.png'),
          ),
          SizedBox(height: 16),
          Text(
            'Harry Meguire',
            style: Theme.of(context).textTheme.headline2!.copyWith(color: CustomColor.black),
            textAlign: TextAlign.center,
          ),
          Text(
            'Asisten',
            style: Theme.of(context).textTheme.headline4!.copyWith(color: CustomColor.black),
            textAlign: TextAlign.center,
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
