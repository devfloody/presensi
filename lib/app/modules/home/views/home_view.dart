import 'package:firebase_auth/firebase_auth.dart';
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
        title: Text('Home'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAllNamed(Routes.LOGIN);
            },
            icon: Icon(IconlyLight.logout),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(16),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: CustomColor.primary,
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
                        color: CustomColor.white,
                      ),
                    ),
                    Text(
                      'Harry Meguire',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '9491102847',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.white,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: CustomColor.white,
                  radius: 30,
                  child: Image.asset('assets/images/avtar.png'),
                ),
              ],
            ),
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
                onPressed: () {},
                child: Text('Lihat Semua'),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 240,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 12),
                  padding: EdgeInsets.all(16),
                  width: 180,
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
                            'Dasar Elektronika',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CustomColor.black,
                            ),
                          ),
                          Text(
                            'A - 7.30 AM',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: CustomColor.grey,
                            ),
                          ),
                          Text(
                            'R. Elektronika',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: CustomColor.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage('assets/images/elc.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 80,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: CustomColor.secondary,
                            primary: CustomColor.black,
                            padding: EdgeInsets.all(4),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Masuk',
                                style: TextStyle(fontSize: 12),
                              ),
                              Icon(
                                IconlyLight.arrow_right_2,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
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
                onPressed: () {},
                child: Text('Lihat Semua'),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 240,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 12),
                  padding: EdgeInsets.all(16),
                  width: 180,
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
                            'Dasar Elektronika',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CustomColor.black,
                            ),
                          ),
                          Text(
                            'A - 7.30 AM',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: CustomColor.grey,
                            ),
                          ),
                          Text(
                            'R. Elektronika',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: CustomColor.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage('assets/images/elc.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 80,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: CustomColor.lightGrey,
                            primary: CustomColor.black,
                            padding: EdgeInsets.all(4),
                          ),
                          child: Text(
                            'Selesai',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
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
              label: 'Home',
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
              label: 'Profile',
              selectedIcon: Icon(IconlyBold.profile),
            ),
          ],
        ),
      ),
    );
  }
}
