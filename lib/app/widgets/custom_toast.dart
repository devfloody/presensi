import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:presensi/app/config/theme.dart';

class CustomToast {
  static errorToast(String? title, String? message) {
    Get.rawSnackbar(
      duration: Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            IconlyBold.close_square,
            color: Colors.white,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    title ?? "error",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  message ?? "Add your error message here",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: CustomColor.error,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      snackPosition: SnackPosition.TOP,
    );
  }

  static warningToast(String? title, String? message) {
    Get.rawSnackbar(
      duration: Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            IconlyBold.info_square,
            color: Colors.white,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    title ?? "Warning",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  message ?? "Add your warning message here",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: CustomColor.warning,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      snackPosition: SnackPosition.TOP,
    );
  }

  static successToast(String? title, String? message) {
    Get.rawSnackbar(
      duration: Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            IconlyBold.tick_square,
            color: Colors.white,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    title ?? "Success",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  message ?? "Add your success message here",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: CustomColor.success,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      snackPosition: SnackPosition.TOP,
    );
  }
}
