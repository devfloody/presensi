import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/absen_controller.dart';

class AbsenView extends GetView<AbsenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AbsenView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AbsenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
