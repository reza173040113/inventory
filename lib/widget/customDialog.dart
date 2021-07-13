import 'dart:ui';
// import 'package:custom_dialog_flutter_demo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/HalamanUtama.dart';
import 'package:inventory/editAsset.dart';
import 'package:inventory/widget/constants.dart';

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
                              margin: EdgeInsets.all(8.0),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(235, 102, 0, 1),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),

                              // color: Colors.orange,
                              child: Text(
                                "Edit",
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
                                  border: Border.all(),
                                  color: Color.fromRGBO(214, 18, 0, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(8.0),
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Hapus",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(4, 141, 204, 1),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(8.0),
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Tutup",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                        ),
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
}
