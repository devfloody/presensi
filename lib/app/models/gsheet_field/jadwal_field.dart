class JadwalField {
  static final String praktikum = "Praktikum";
  static final String asisten = "Asisten";
  static final String kodePraktikum = "Kode Praktikum";
  static final String kelas = "Kelas";
  static final String dosen = "Dosen Pengampu";
  static final String hari = "Hari";
  static final String jumlahMahasiswa = "Jumlah Mahasiswa";

  static List<String> getJadwalFields() => [
        asisten,
        praktikum,
        kodePraktikum,
        kelas,
        dosen,
        hari,
        jumlahMahasiswa,
      ];
}
