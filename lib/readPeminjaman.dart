import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory/widget/customDialog.dart';
import 'package:inventory/widget/customDialogPeminjaman.dart';

import 'generate.dart';

class ReadPeminjaman extends StatefulWidget {
  @override
  _ReadPeminjamanState createState() => _ReadPeminjamanState();
}

class _ReadPeminjamanState extends State<ReadPeminjaman> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 40),
                child: Text("Laporan Peminjaman",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Peminjaman").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.docs[index];
                        Map<String, dynamic> task = documentSnapshot.data();
                        return GestureDetector(
                          child: InkWell(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Container(
                                  child: SizedBox(
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.all(8.0),
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                                elevation: 5,
                                                margin: EdgeInsets.all(5),
                                                child: InkWell(
                                                  onTap: () async {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (BuildContext context) {
                                                          return CustomDialogPeminjaman(
                                                            documentId:
                                                                documentSnapshot.id,
                                                                nama: task['namaPeminjam'],
                                                            namaBarang:
                                                                task['namaBarang'],
                                                            
                                                            tanggalPinjam:
                                                                task['tglPinjam'],
                                                            tanggalKembali:
                                                                task['tglPengembalian'],
                                                            
                                                            jumlah:
                                                                task['jmlBarang'],
                                                            
                                                          );
                                                        });
                                                  },
                                                  child: ListTile(
                                                    title: Text(
                                                      task['namaPeminjam'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.brown),
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                            "Nama Barang : ${task['namaBarang']}"),
                                                        // Text("Tanggal :" +
                                                        //     dateString)
                                                      ],
                                                    ),
                                                    // trailing:
                                                  ),
                                                ))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
