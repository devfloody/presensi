import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpdateProfileView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UpdateProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
