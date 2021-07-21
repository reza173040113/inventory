import 'dart:io';
import 'dart:ui';
// import 'package:custom_dialog_flutter_demo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory/HalamanUtama.dart';
import 'package:inventory/editAsset.dart';
import 'package:inventory/widget/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CustomDialogPeminjaman extends StatefulWidget {
  final String documentId, namaBarang, nama;

  final int jumlah;
  final Timestamp tanggalPinjam, tanggalKembali;

  const CustomDialogPeminjaman(
      {Key key,
      this.nama,
      this.documentId,
      this.namaBarang,
      this.jumlah,
      this.tanggalPinjam,
      this.tanggalKembali})
      : super(key: key);

  @override
  _CustomDialogPeminjamanState createState() => _CustomDialogPeminjamanState();
}

class _CustomDialogPeminjamanState extends State<CustomDialogPeminjaman> {
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
    DateTime dateNow = Timestamp.fromMillisecondsSinceEpoch(
            widget.tanggalPinjam.millisecondsSinceEpoch)
        .toDate();
    var format = new DateFormat('dd/MM/yyyy');
    DateTime dateNow2 = Timestamp.fromMillisecondsSinceEpoch(
            widget.tanggalKembali.millisecondsSinceEpoch)
        .toDate();
    var format2 = new DateFormat('dd/MM/yyyy');
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
                    "Nama  : " + widget.nama,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nama Barang : " + widget.namaBarang,
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
                    "Tanggal Pinjam : " + format.format(dateNow),
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
                    "Tanggal Kembali : " + format2.format(dateNow2).toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                SizedBox(
                  height: 3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Jumlah : " + widget.jumlah.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 3,
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
                          onTap: () async {
                            final dir = await getExternalStorageDirectory();
                            print("Directoryyyyyyyyy:${dir.path}");
                            final pdf = pw.Document();
                            const _darkColor = PdfColor.fromInt(0xff242424);
                            const PdfColor accentColor =
                                PdfColor.fromInt(0xfff1c0c0);

                            final headers = [
                              'Nama',
                              'Nama Barang',
                              'Jumlah',
                              'Tanggal Pinjam',
                              'Tanggal Kembali',
                            ];

                            pdf.addPage(pw.MultiPage(
                                build: (context) => <pw.Widget>[
                                      pw.Header(
                                          level: 0,
                                          child: pw.Container(
                                              decoration:
                                                  const pw.BoxDecoration(
                                                color: PdfColor.fromInt(
                                                    0xffffffff),
                                              ),
                                              margin: const pw.EdgeInsets.only(
                                                  bottom: 8, top: 8),
                                              padding:
                                                  const pw.EdgeInsets.fromLTRB(
                                                      10, 7, 10, 4),
                                              child: pw.Column(children: [
                                                pw.Text(
                                                  "Surat Peminjaman Asset",
                                                  style: pw.TextStyle(
                                                      fontSize: 16,
                                                      color: _darkColor,
                                                      fontWeight:
                                                          pw.FontWeight.bold),
                                                ),
                                                // pw.Text("+6287788169658",
                                                //     style: pw.TextStyle(
                                                //         fontSize: 14,
                                                //         color: _darkColor)),
                                                // pw.Text("Regezaga, Brebes",
                                                //     style: pw.TextStyle(
                                                //         fontSize: 14,
                                                //         color: _darkColor)),
                                                pw.Divider(color: accentColor),
                                              ]))),
                                      pw.Table.fromTextArray(
                                          headers: headers,
                                          data: <List<String>>[
                                            <String>[
                                              widget.nama,
                                              widget.namaBarang,
                                              widget.jumlah.toString(),
                                              format.format(dateNow),
                                              format2.format(dateNow2),
                                            ]
                                          ]),
                                    ]));

                            final file =
                                File('${dir.path}/+${widget.nama}.pdf');
                            await file.writeAsBytes(await pdf.save());
                            Fluttertoast.showToast(
                                msg: "Data berhasil disimpan di ${dir.path}/+${widget.nama}.pdf",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(4, 141, 204, 1),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(8.0),
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Export",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                        ),
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
