import 'package:cloud_firestore/cloud_firestore.dart';

class PeminjamanModel {
  Future<DocumentSnapshot> addPeminjaman(peminjaman, namaBarang) {
    CollectionReference pinjaman =
        FirebaseFirestore.instance.collection('Peminjaman');

    pinjaman.doc().set(peminjaman).whenComplete(() {
      print("$peminjaman sudah dibuat");
    });
  }
}
