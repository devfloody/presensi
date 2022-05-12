import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/app/config/theme.dart';

class EulaView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syarat dan Ketentuan'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              'Presensi App',
              style: Theme.of(context).textTheme.headline1!.copyWith(color: CustomColor.primary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Center(
              child: ClipOval(
                child: Container(
                  width: 120,
                  height: 120,
                  color: CustomColor.primary,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 60,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- Syarat dan Ketentuan Aplikasi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.black,
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Syarat dan Ketentuan pengguna Presensi App ini dibuat sebagai informasi untuk mengenai penggunaan aplikasi Presensi App. Syarat dan Ketentuan ini dibuat untuk membantu pengguna dalam menggunakan aplikasi Presensi App.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CustomColor.grey,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- Kewajiban Pengguna',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.black,
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Setiap pengguna wajid untuk menyetujui syarat dan ketentuan ini sebelum menggunakan aplikasi Presensi App.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CustomColor.grey,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- Hak Pengguna',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.black,
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Setiap pengguna berhak untuk menggunakan aplikasi Presensi App dengan syarat dan ketentuan yang dibuat oleh Presensi App. Pengguna tidak diperkenankan untuk mengubah, menambah, atau menghapus isi aplikasi Presensi App.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CustomColor.grey,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- Kewajiban Developer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.black,
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Developer wajib untuk menjaga kerahasiaan data pengguna yang terdaftar di aplikasi Presensi App.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CustomColor.grey,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- Hak Developer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.black,
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Developer berhak untuk mengubah, menambah, atau menghapus isi aplikasi Presensi App tanpa pemberitahuan terlebih dahulu.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CustomColor.grey,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
