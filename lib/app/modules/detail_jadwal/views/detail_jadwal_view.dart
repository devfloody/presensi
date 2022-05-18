import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_jadwal_controller.dart';

class DetailJadwalView extends GetView<DetailJadwalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailJadwalView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailJadwalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
