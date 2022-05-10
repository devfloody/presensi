import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/config/theme.dart';

import '../controllers/add_jadwal_controller.dart';

class AddJadwalView extends GetView<AddJadwalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Jadwal'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamJadwal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(16),
                  height: 160,
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
                                'Praktikum\n${data.docs[index].data()['nama']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColor.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text('Kode : ${data.docs[index].data()['kode']}'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dosen : ${data.docs[index].data()['dosen']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.black,
                                ),
                              ),
                              Text(
                                'Ruang : ${data.docs[index].data()['ruang']}',
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
                                data.docs[index].data()['kelas'],
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
                              color: CustomColor.secondary,
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                  size: 32,
                                  color: CustomColor.white,
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
          }
          return Center(
            child: Text('Tidak dapat memuat data'),
          );
        },
      ),
    );
  }
}
