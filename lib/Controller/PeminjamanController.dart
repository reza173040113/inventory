import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/Model/PeminjamanModel.dart';

class PeminjamanController {
  PeminjamanModel pm = new PeminjamanModel();
  Future<DocumentSnapshot> pinjam(String namaPeminjam, String namaBarang,
      Timestamp tglPinjam, int jumlahPinjam, Timestamp tglPengembalian) async {
    Map<String, dynamic> peminjaman = {
      "namaPeminjam": namaPeminjam,
      "namaBarang": namaBarang,
      "tglPinjam": tglPinjam,
      "jmlBarang": jumlahPinjam,
      "tglPengembalian": tglPengembalian,
    };
    pm.addPeminjaman(peminjaman, namaBarang);
  }
}
