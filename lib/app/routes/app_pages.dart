import 'package:get/get.dart';

import 'package:presensi/app/modules/absen/bindings/absen_binding.dart';
import 'package:presensi/app/modules/absen/views/absen_view.dart';
import 'package:presensi/app/modules/detail_absensi/bindings/detail_absensi_binding.dart';
import 'package:presensi/app/modules/detail_absensi/views/detail_absensi_view.dart';
import 'package:presensi/app/modules/detail_jadwal/bindings/detail_jadwal_binding.dart';
import 'package:presensi/app/modules/detail_jadwal/views/detail_jadwal_view.dart';
import 'package:presensi/app/modules/edit_jadwal/bindings/edit_jadwal_binding.dart';
import 'package:presensi/app/modules/edit_jadwal/views/edit_jadwal_view.dart';

import '../modules/add_jadwal/bindings/add_jadwal_binding.dart';
import '../modules/add_jadwal/views/add_jadwal_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/jadwal/bindings/jadwal_binding.dart';
import '../modules/jadwal/views/jadwal_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lupa_password/bindings/lupa_password_binding.dart';
import '../modules/lupa_password/views/lupa_password_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/views/tentang_view.dart';
import '../modules/riwayat/bindings/riwayat_binding.dart';
import '../modules/riwayat/views/riwayat_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/eula_view.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/update_password/bindings/update_password_binding.dart';
import '../modules/update_password/views/update_password_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';

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
    GetPage(
      name: _Paths.TENTANG,
      page: () => TentangView(),
    ),
    GetPage(
      name: _Paths.EULA,
      page: () => EulaView(),
    ),
    GetPage(
      name: _Paths.ADD_JADWAL,
      page: () => AddJadwalView(),
      binding: AddJadwalBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PASSWORD,
      page: () => LupaPasswordView(),
      binding: LupaPasswordBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN,
      page: () => AbsenView(),
      binding: AbsenBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_JADWAL,
      page: () => EditJadwalView(),
      binding: EditJadwalBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_JADWAL,
      page: () => DetailJadwalView(),
      binding: DetailJadwalBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ABSENSI,
      page: () => DetailAbsensiView(),
      binding: DetailAbsensiBinding(),
    ),
  ];
}
