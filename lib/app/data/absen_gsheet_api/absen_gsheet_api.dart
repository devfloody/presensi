import 'package:gsheets/gsheets.dart';

import '../../models/gsheet_field/jadwal_field.dart';
import '../../models/gsheet_field/rekap_field.dart';

class AbsenSheetApi {
  static final _spreadsheetId = '1gMP0f9Ogr8yBOUEh_9a_bPMAX82lykI8P_DsHszFtX4';
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "presensi-9b358",
  "private_key_id": "fc316dde26e06afbadd9dceccd003c642ebae16f",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEugIBADANBgkqhkiG9w0BAQEFAASCBKQwggSgAgEAAoIBAQCjCWyNLcnvlmK9\nWd/flgmkT+b9UvPbHlXVyB9ZTgdYHHPK0cOhC6t2oCynXXsscD0ANWDyz2m3h6Pl\nfY/rjbXzVilUJut2aILOBWkBRWi+Bkrhgr8Ahmm3lzL5BM6ebA9pBAIJKkHwjuSI\nmPMZEJ8FVyAVszKtWUVPUXRaRg4xxPTHAEo6YhgLm4pQaZWdbrgl2FXHHHmwd4MX\nrpJKuJy//fNMnlgV+wwSdlp+v7f2t4nTYg7ZRAKbSOv/FXu141BpJqFrZqzK1KhW\nPsLmXrfJESzmcxNvkViABnRc72btBSE9cp/UBx25AgB8avxExIUKyNEI82M2m73P\nXAIgtPRLAgMBAAECggEAAsNaOYRN2IeLpQ2v+4aVidlCBW4RkvE1kpnbKif/4nbm\nlK8WA5WcJZ0H7k6ck7K6ESK822PRG1qrPoYjv8hXJ2IaiwIQpu37glYmIu7g6RBY\nCYouBlDA27f7L0XTe9NCAzO3SYRG7NBHJqeAJNJN/gjgrG15wOVZhUNQpDNtJY71\nhjsyT/pPMOEvYZzosGAwwGx3to/VWs3/xJiLNTbeNbjBXxAVPf4BhuBdXulH/CCH\nh49eS41kd9+DmV8+gSC+Wza/mqTj2A026xUDRd3sWWdE/eBpASZKdb3932SlnT9C\nGckhXV8eTgmPfVXXw8pNQ27Z7l97k90a8JOY65PnoQKBgQDcpwZ5uOjQAJU+aMnm\nHs3euuTdjDvj7CPD5yRfowiDWF5Rs36I1D+xQwbHHeTT2GpCw8G1rv9BKW79USuT\nwePUbiAnySVHnw5SAMCjE7YKOWN+snaE5KQAbvDM8JmG4J4aaQk9c/lQQyQ87i45\nxN57ls7711CdZNkbkpE/yyDt4QKBgQC9J5O49MHqH3N8g7vTzLLMOxMnI3MCLato\nHQm/YD41/MFsB3fUrcuZe7m8KB7imGL564hpRXIWXQrk0Vo0ND8IYQORHznWiX/o\napMtkIKwtnb8ybWYQWFePHM0XlFDhvsaOfq3eE4LVTbozZE1pHYT7p0d6AnnOqKS\ni623/cHvqwKBgBfl1yOzzTNJ/OAHhWZxC6cF4ufD2nCzEKSVEjFxfOiM15pNsHSt\nWECgm8lRCYmQNOIKRZ6h1299R1IUSn30T/KgAseMV4dMSMbE4hhHeD3fPVFpjsCR\n6tlJKrdnj5k2FqmRmriXKPdybihTO5pyIg6MpNpN1aNWWtVLqIOaQnTBAn8HY4Rh\ntS3d91yLgJnVrClP0P7uiHP1odMQPhIjZ58GfNkRXzlPFXreg/a9YtPSBiHXoVuy\nwQOz2+6RAZyEbYYIzcFV6eJYfwaADamyHfL89COxvC9bwzIKfFIDuaty99LXM2yX\nvhtOVgXPEjiZ39K89JUuleHNJn0zPEGM7lylAoGAAjemNMgGdZhYRLqUxSouUMY1\nRCO51pQ5ttgEQvjjGmjLUMyZ0cr0KNMD+447UhVmKvS0nO0h3RQ/visdlCQzGGzX\nGYacn42JvcSg7wkgjnoKwtijZTxTA5PrxV/q2BXB+WEnrimQ8lI+WtHXkEp+eYmb\no4EYxBx9aAowzHY2Dek=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheet@presensi-9b358.iam.gserviceaccount.com",
  "client_id": "103311772783176259923",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheet%40presensi-9b358.iam.gserviceaccount.com"
  }
  ''';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? presensiSheet, jadwalSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      presensiSheet = await _getWorkSheet(spreadsheet, title: "Rekap");
      jadwalSheet = await _getWorkSheet(spreadsheet, title: "Jadwal");
      final barisPertamaRekap = RekapField.getRekapFields();
      final barisPertamaJadwal = JadwalField.getJadwalFields();
      presensiSheet!.values.insertRow(1, barisPertamaRekap);
      jadwalSheet!.values.insertRow(1, barisPertamaJadwal);
    } catch (e) {
      print('Error init : $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet, {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
}
