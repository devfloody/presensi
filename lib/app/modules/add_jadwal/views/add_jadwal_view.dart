import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_jadwal_controller.dart';

class AddJadwalView extends GetView<AddJadwalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddJadwalView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddJadwalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
