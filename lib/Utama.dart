import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/AddAsset.dart';
import 'package:inventory/detail/detail.dart';
import 'package:inventory/generate.dart';
import 'package:inventory/widget/cardInventory.dart';
import 'package:inventory/widget/customDialog.dart';

class Utama extends StatefulWidget {
  @override
  _UtamaState createState() => _UtamaState();
}

class _UtamaState extends State<Utama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Use children total size
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddAsset()));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 40, left: 8.0, right: 8.0),
                padding: const EdgeInsets.all(8.0),
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF065125),
                ),
                child: Center(
                  child: Text(
                    "Add New ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Barang").snapshots(),
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
                                          // child: Card(
                                          //   shape: RoundedRectangleBorder(
                                          //       borderRadius: BorderRadius.all(
                                          //           Radius.circular(8.0))),
                                          //   child: InkWell(
                                          //     onTap: () async {
                                          //       // bool result =
                                          //       //     await Navigator
                                          //       //         .push(
                                          //       //   context,
                                          //       //   MaterialPageRoute(
                                          //       //       builder:
                                          //       //           (context) {
                                          //       //     return DetailCampaign(
                                          //       //       documentId:
                                          //       //           documentSnapshot
                                          //       //               .documentID,
                                          //       //       namaCampaign:
                                          //       //           task[
                                          //       //               'namaCampaign'],
                                          //       //       deskripsi:
                                          //       //           task[
                                          //       //               'deskripsi'],
                                          //       //       danaCampaign:
                                          //       //           task[
                                          //       //               'danaCampaign'],
                                          //       //       danaTerkumpul:
                                          //       //           task[
                                          //       //               'danaTerkumpul'],
                                          //       //       gambarCampaign:
                                          //       //           task[
                                          //       //               'gambarCampaign'],
                                          //       //       kategori:
                                          //       //           task[
                                          //       //               'kategori'],
                                          //       //       tanggal: task[
                                          //       //           'tanggal'],
                                          //       //     );
                                          //       //   }),
                                          //       // );
                                          //     },
                                          //     child: Column(
                                          //       children: <Widget>[
                                          //         CampCard(
                                          //           namaBarang: documentSnapshot
                                          //               .data()['namaBarang'],
                                          //           merk: documentSnapshot
                                          //               .data()['merk'],
                                          //           statusBarang: documentSnapshot
                                          //               .data()['statusBarang'],
                                          //           kodeBarang: documentSnapshot
                                          //               .data()['kodeBarang'],
                                          //           jmlBarang: documentSnapshot
                                          //               .data()['jmlBarang'],
                                          //           keterangan: documentSnapshot
                                          //               .data()['keterangan'],
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),

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
                                                      builder: (BuildContext
                                                          context) {
                                                        return CustomDialogBox(
                                                          namaBarang: task[
                                                              'namaBarang'],
                                                          merk: task['merk'],
                                                          thnBuat:
                                                              task['thnBuat'],
                                                          kodeBarang: task[
                                                              'kodeBarang'],
                                                          statusBarang: task[
                                                              'statusBarang'],
                                                          jmlBarang:
                                                              task['jmlBarang'],
                                                          keterangan: task[
                                                              'keterangan'],
                                                          text: "Yes",
                                                        );
                                                      });

                                                  // bool result =
                                                  //     await Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) {
                                                  //     return Detail(
                                                  //       documentId:
                                                  //           documentSnapshot.id,
                                                  //       namaBarang:
                                                  //           task['namaBarang'],
                                                  //       merk: task['merk'],
                                                  //       statusBarang: task[
                                                  //           'statusBarang'],
                                                  //       jmlBarang:
                                                  //           task['jmlBarang'],
                                                  //       keterangan:
                                                  //           task['keterangan'],
                                                  //       kodeBarang:
                                                  //           task['kodeBarang'],
                                                  //     );
                                                  //   }),
                                                  // );
                                                },
                                                child: ListTile(
                                                  title: Text(
                                                    task['namaBarang'],
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "Kesediaan : ${task['namaBarang']}"),
                                                      // Text("Tanggal :" +
                                                      //     dateString)
                                                    ],
                                                  ),
                                                  trailing: IconButton(
                                                    icon: Icon(Icons.scanner),
                                                    onPressed: () async {
                                                      bool result =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                          return Generate(
                                                            documentId:
                                                                documentSnapshot
                                                                    .id,
                                                            nama: task[
                                                                'namaBarang'],
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
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
      ),
    );
  }
}
