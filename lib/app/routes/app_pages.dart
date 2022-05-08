import 'package:get/get.dart';

import 'package:presensi/app/modules/home/bindings/home_binding.dart';
import 'package:presensi/app/modules/home/views/home_view.dart';
import 'package:presensi/app/modules/jadwal/bindings/jadwal_binding.dart';
import 'package:presensi/app/modules/jadwal/views/jadwal_view.dart';
import 'package:presensi/app/modules/login/bindings/login_binding.dart';
import 'package:presensi/app/modules/login/views/login_view.dart';
import 'package:presensi/app/modules/profile/bindings/profile_binding.dart';
import 'package:presensi/app/modules/profile/views/profile_view.dart';
import 'package:presensi/app/modules/riwayat/bindings/riwayat_binding.dart';
import 'package:presensi/app/modules/riwayat/views/riwayat_view.dart';
import 'package:presensi/app/modules/signup/bindings/signup_binding.dart';
import 'package:presensi/app/modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => RiwayatView(),
      binding: RiwayatBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.JADWAL,
      page: () => JadwalView(),
      binding: JadwalBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
