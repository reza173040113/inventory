import 'package:cloud_firestore/cloud_firestore.dart';

class BarangModel {
  Future<DocumentSnapshot> addBarangModel(barang, kodeBarang) {
    CollectionReference barangs =
        FirebaseFirestore.instance.collection('Barang');

    barangs.doc(kodeBarang).set(barang).whenComplete(() {
      print("$kodeBarang sudah dibuat");
    });
  }

  Future<DocumentSnapshot> editBarangModel(barang, kodeBarang) {
    DocumentReference barangs =
        FirebaseFirestore.instance.collection('Barang').doc(kodeBarang);

    barangs.set(barang).whenComplete(() {
      print("$kodeBarang sudah dibuat");
    });
  }

  Future<DocumentSnapshot> deletbarangModel(kodeBarang) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Barang").doc(kodeBarang);

    documentReference.delete().whenComplete(() {
      print(kodeBarang + "deleted");
    });
  }
}
