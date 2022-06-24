class RekapField {
  static final String asisten = 'Asisten Pengajar';
  static final String praktikum = 'Mata Praktikum';
  static final String kode = 'Kode Praktikum';
  static final String kelas = 'Kelas';
  static final String ruang = 'Ruang Praktikum';
  static final String dosen = 'Dosen Pengampu';
  static final String status = 'Status Kehadiran Dosen';
  static final String hari = 'Hari';
  static final String tanggal = 'Tanggal';
  static final String jam = 'Jam';
  static final String jumlahHadir = 'Jumlah Praktikan Hadir';
  static final String jumlahTidakHadir = 'Jumlah Praktikan Tidak Hadir';
  static final String materi = 'Materi Praktikum';

  static List<String> getRekapFields() => [
        asisten,
        praktikum,
        kode,
        kelas,
        ruang,
        dosen,
        status,
        hari,
        tanggal,
        jam,
        jumlahHadir,
        jumlahTidakHadir,
        materi,
      ];
}
