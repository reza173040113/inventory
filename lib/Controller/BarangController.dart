import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/Model/BarangModel.dart';

class BarangController {
  BarangModel bm = new BarangModel();
  Future<DocumentSnapshot> addBarang(
      String namaBarang,
      String merk,
      String statusBarang,
      String kodeBarang,
      int thnBuat,
      int jmlBarang,
      String keterangan) async {
    Map<String, dynamic> barang = {
      "namaBarang": namaBarang,
      "merk": merk,
      "thnBuat": thnBuat,
      "statusBarang": statusBarang,
      "kodeBarang": kodeBarang,
      "keterangan": keterangan,
      "jmlBarang": jmlBarang
    };
    bm.addBarangModel(barang, kodeBarang);
  }

  Future<DocumentSnapshot> editBarang(
      String namaBarang,
      String merk,
      String statusBarang,
      String kodeBarang,
      int thnBuat,
      int jmlBarang,
      String keterangan) async {
    Map<String, dynamic> barang = {
      "namaBarang": namaBarang,
      "merk": merk,
      "thnBuat": thnBuat,
      "statusBarang": statusBarang,
      "kodeBarang": kodeBarang,
      "keterangan": keterangan,
      "jmlBarang": jmlBarang
    };
    bm.editBarangModel(barang, kodeBarang);
  }

  Future<DocumentSnapshot> updateJmlBarang(
      String namaBarang,
      String merk,
      String statusBarang,
      String kodeBarang,
      int thnBuat,
      int jumlahBarangTersisa,
      String keterangan) async {
    Map<String, dynamic> barang = {
      "namaBarang": namaBarang,
      "merk": merk,
      "thnBuat": thnBuat,
      "statusBarang": statusBarang,
      "kodeBarang": kodeBarang,
      "keterangan": keterangan,
      "jmlBarang": jumlahBarangTersisa
    };
    bm.editBarangModel(barang, kodeBarang);
  }
}
