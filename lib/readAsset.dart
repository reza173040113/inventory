import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory/widget/customDialog.dart';

import 'generate.dart';

class Read extends StatefulWidget {
  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(margin: EdgeInsets.only(top:40), child:Text("Laporan Asset Inventory",style:TextStyle(fontSize: 24,fontWeight:FontWeight.bold))),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Barang").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
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
                                                      return CustomDialogBox(
                                                        documentId:
                                                            documentSnapshot.id,
                                                        namaBarang:
                                                            task['namaBarang'],
                                                        merk: task['merk'],
                                                        thnBuat: task['thnBuat'],
                                                        kodeBarang:
                                                            task['kodeBarang'],
                                                        statusBarang:
                                                            task['statusBarang'],
                                                        jmlBarang:
                                                            task['jmlBarang'],
                                                        keterangan:
                                                            task['keterangan'],
                                                        text: "Yes",
                                                      );
                                                    });
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  task['namaBarang'],
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.brown),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Kesediaan : ${task['namaBarang']}"),
                                                    // Text("Tanggal :" +
                                                    //     dateString)
                                                  ],
                                                ),
                                                // trailing:
                                                trailing: IconButton(
                                                    icon: Image.asset(
                                                      "assets/images/qrcode.png",
                                                      height: 20,
                                                    ),
                                                    onPressed: () async {
                                                      bool result =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                          return Generate(
                                                            documentId:
                                                                documentSnapshot.id,
                                                            nama:
                                                                task['namaBarang'],
                                                          );
                                                        }),
                                                      );
                                                    }),
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
        ],
      ),
    );
  }
}
