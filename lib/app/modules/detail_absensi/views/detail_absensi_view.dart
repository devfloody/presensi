import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_absensi_controller.dart';

class DetailAbsensiView extends GetView<DetailAbsensiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailAbsensiView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailAbsensiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
