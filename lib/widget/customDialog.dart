import 'dart:io';
import 'dart:ui';
// import 'package:custom_dialog_flutter_demo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/HalamanUtama.dart';
import 'package:inventory/editAsset.dart';
import 'package:inventory/pinjaman.dart';
import 'package:inventory/widget/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CustomDialogBox extends StatefulWidget {
  final String documentId,
      namaBarang,
      merk,
      kodeBarang,
      statusBarang,
      keterangan,
      text;
  final int jmlBarang, thnBuat;

  const CustomDialogBox(
      {Key key,
      this.merk,
      this.text,
      this.documentId,
      this.namaBarang,
      this.kodeBarang,
      this.statusBarang,
      this.keterangan,
      this.jmlBarang,
      this.thnBuat})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nama Barang : " + widget.namaBarang,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Merk : " + widget.merk,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tahun dibuat : " + widget.thnBuat.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Kode : " + widget.kodeBarang,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Status Barang : " + widget.statusBarang,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Jumlah Barang : " + widget.jmlBarang.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Keterangan : ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.keterangan,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                  height: 70,
                  // margin: EdgeInsets.all(8.0),
                  // padding: EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Row(
                      // scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Peminjaman(
                                  namaBarang: widget.namaBarang,
                                  merk: widget.merk,
                                  thnBuat: widget.thnBuat,
                                  kodeBarang: widget.kodeBarang,
                                  statusBarang: widget.statusBarang,
                                  jmlBarang: widget.jmlBarang,
                                  keterangan: widget.keterangan,
                                );
                                // Generate(
                                //   documentId: documentSnapshot.id,
                                //   nama: task['namaBarang'],
                                // );
                              }),
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),

                              // color: Colors.orange,
                              child: Text(
                                "Pinjam",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold,),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return EditAsset(
                                  namaBarang: widget.namaBarang,
                                  merk: widget.merk,
                                  thnBuat: widget.thnBuat,
                                  kodeBarang: widget.kodeBarang,
                                  statusBarang: widget.statusBarang,
                                  jmlBarang: widget.jmlBarang,
                                  keterangan: widget.keterangan,
                                );
                                // Generate(
                                //   documentId: documentSnapshot.id,
                                //   nama: task['namaBarang'],
                                // );
                              }),
                            );
                          },
                          child: Container(
                              margin: EdgeInsets.only(left:8.0),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 169, 0,1),
                                  borderRadius: BorderRadius.circular(10)),

                              // color: Colors.orange,
                              child: Text(
                                "Ubah",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      Text("Yakin ingin menghapus barang ini?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ya'),
                                      onPressed: () {
                                        // createData();
                                        // database.createData(name, deskripsi);
                                        DocumentReference documentReference =
                                            FirebaseFirestore.instance
                                                .collection("Barang")
                                                .doc(widget.kodeBarang);

                                        documentReference
                                            .delete()
                                            .whenComplete(() {
                                          print(widget.kodeBarang + "deleted");
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Barang Inventaris berhasil dihapus!!!'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('Ok'),
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new HalamanUtama()));
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Tidak'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(205, 17, 59, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(8.0),
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Hapus",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                        ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     final dir = await getExternalStorageDirectory();
                        //     print("Directoryyyyyyyyy:${dir.path}");
                        //     final pdf = pw.Document();
                        //     const _darkColor = PdfColor.fromInt(0xff242424);
                        //     const PdfColor accentColor =
                        //         PdfColor.fromInt(0xfff1c0c0);

                        //     final headers = [
                        //       'Kode',
                        //       'Nama Barang',
                        //       'Merk',
                        //       'Tahun Dibuat',
                        //       'Status',
                        //       'Jumlah',
                        //       'Keterangan'
                        //     ];

                        //     pdf.addPage(pw.MultiPage(
                        //         build: (context) => <pw.Widget>[
                        //               pw.Header(
                        //                   level: 0,
                        //                   child: pw.Container(
                        //                       decoration:
                        //                           const pw.BoxDecoration(
                        //                         color: PdfColor.fromInt(
                        //                             0xffffffff),
                        //                       ),
                        //                       margin: const pw.EdgeInsets.only(
                        //                           bottom: 8, top: 8),
                        //                       padding:
                        //                           const pw.EdgeInsets.fromLTRB(
                        //                               10, 7, 10, 4),
                        //                       child: pw.Column(children: [
                        //                         pw.Text(
                        //                           "Surat Peminjaman Asset",
                        //                           style: pw.TextStyle(
                        //                               fontSize: 16,
                        //                               color: _darkColor,
                        //                               fontWeight:
                        //                                   pw.FontWeight.bold),
                        //                         ),
                        //                         pw.Text("+6287788169658",
                        //                             style: pw.TextStyle(
                        //                                 fontSize: 14,
                        //                                 color: _darkColor)),
                        //                         pw.Text("Regezaga, Brebes",
                        //                             style: pw.TextStyle(
                        //                                 fontSize: 14,
                        //                                 color: _darkColor)),
                        //                         pw.Divider(color: accentColor),
                        //                       ]))),
                        //               pw.Table.fromTextArray(
                        //                   headers: headers,
                        //                   data: <List<String>>[
                        //                     <String>[
                        //                       widget.kodeBarang,
                        //                       widget.namaBarang,
                        //                       widget.merk,
                        //                       widget.thnBuat.toString(),
                        //                       widget.statusBarang,
                        //                       widget.jmlBarang.toString(),
                        //                       widget.keterangan
                        //                     ]
                        //                   ]),
                        //             ]));

                        //     final file = File('${dir.path}/+${widget.kodeBarang}.pdf');
                        //     await file.writeAsBytes(await pdf.save());
                        //   },
                        //   child: Container(
                        //       decoration: BoxDecoration(
                        //           color: Color.fromRGBO(4, 141, 204, 1),
                        //           border: Border.all(),
                        //           borderRadius: BorderRadius.circular(10)),
                        //       margin: EdgeInsets.all(8.0),
                        //       padding: EdgeInsets.all(8.0),
                        //       child: Text(
                        //         "Export",
                        //         style: TextStyle(
                        //             fontSize: 17, fontWeight: FontWeight.bold),
                        //       )),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).pop();
                        //   },
                        //   child: Container(
                        //       decoration: BoxDecoration(
                        //           color: Color.fromRGBO(4, 141, 204, 1),
                        //           border: Border.all(),
                        //           borderRadius: BorderRadius.circular(10)),
                        //       margin: EdgeInsets.all(8.0),
                        //       padding: EdgeInsets.all(8.0),
                        //       child: Text(
                        //         "Tutup",
                        //         style: TextStyle(
                        //             fontSize: 17, fontWeight: FontWeight.bold),
                        //       )),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   left: Constants.padding,
        //   right: Constants.padding,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.transparent,
        //     radius: Constants.avatarRadius,
        //     child: ClipRRect(
        //         borderRadius:
        //             BorderRadius.all(Radius.circular(Constants.avatarRadius)),
        //         child: Image.asset("assets/model.jpg")),
        //   ),
        // ),
      ],
    );
  }

  Widget pdfHeader() {}
}
