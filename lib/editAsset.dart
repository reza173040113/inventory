import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/HalamanUtama.dart';
import 'package:inventory/Utama.dart';

class EditAsset extends StatefulWidget {
  final String documentId,
      namaBarang,
      merk,
      kodeBarang,
      statusBarang,
      keterangan;
  final int jmlBarang, thnBuat;

  EditAsset({
    @required this.documentId,
    @required this.namaBarang,
    @required this.merk,
    @required this.thnBuat,
    @required this.kodeBarang,
    @required this.statusBarang,
    @required this.keterangan,
    @required this.jmlBarang,
  });
  @override
  _EditAssetState createState() => _EditAssetState();
}

class _EditAssetState extends State<EditAsset> {
  String dropDownValue;
  List<String> list = [
    'Baik Sekali',
    'Baik',
    'Kurang Baik',
    'Kurang Baik Sekali'
  ];
  String _selectedIndex = "Baik";
  String namaBarang, merk, thnBuat, kodeBarang, statusBarang, keterangan;
  int jmlBarang;
  TextEditingController controllerNamaBarang = TextEditingController();
  TextEditingController controllerMerk = TextEditingController();
  TextEditingController controllerThnBuat = TextEditingController();
  TextEditingController controllerStatusBarang = TextEditingController();
  TextEditingController controllerKodeBarang = TextEditingController();
  TextEditingController controllerKeterangan = TextEditingController();
  TextEditingController controllerJmlBarang = TextEditingController();
  var txt = TextEditingController();

  // final flutrans = Flutrans();

// controller dan model data

  getNamaBarang(namaBarang) {
    this.namaBarang = namaBarang;
  }

  getMerk(merk) {
    this.merk = merk;
  }

  getThnBuat(thnBuat) {
    this.thnBuat = thnBuat;
  }

  getKodeBarang(kodeBarang) {
    this.kodeBarang = kodeBarang;
  }

  getStatusBarang(statusBarang) {
    this.statusBarang = statusBarang;
  }

  getKeterangan(keterangan) {
    this.keterangan = keterangan;
  }

  getJmlBarang(jmlBarang) {
    this.jmlBarang = int.parse(jmlBarang);
  }

  @override
  void initState() {
    super.initState();
    controllerNamaBarang.text = widget.namaBarang.toString();
    controllerMerk.text = widget.merk.toString();
    controllerStatusBarang.text = widget.statusBarang.toString();
    controllerKeterangan.text = widget.keterangan.toString();
    controllerJmlBarang.text = widget.jmlBarang.toString();
    controllerThnBuat.text = widget.thnBuat.toString();
    controllerKodeBarang.text = widget.kodeBarang.toString();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [],
          title: Text(
            "Edit Inventory Page",
          ),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LimitedBox(
                  maxWidth: 150.0,
                  child: TextFormField(
                    controller: controllerNamaBarang,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Nama Barang",
                      labelStyle: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "isi nama barang",
                    ),
                    onChanged: (String namaBarang) {
                      getNamaBarang(namaBarang);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LimitedBox(
                  maxWidth: 150.0,
                  child: TextFormField(
                    controller: controllerMerk,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Merk / Label",
                      labelStyle: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Masukkan merek barang",
                      hintStyle: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    onChanged: (String merk) {
                      getMerk(merk);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LimitedBox(
                  maxWidth: 150.0,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controllerThnBuat,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Tahun Buat",
                      labelStyle: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Masukkan tahun barang dibuat",
                      hintStyle: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    onChanged: (String thnBuat) {
                      getThnBuat(thnBuat);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 5),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Status Barang",
                  fillColor: Colors.white),
              value: controllerStatusBarang.text,
              onChanged: (String Value) {
                setState(() {
                  dropDownValue = Value;
                });
              },
              items: list
                  .map((listTitle) => DropdownMenuItem(
                      value: listTitle, child: Text("$listTitle")))
                  .toList(),
            ),
            // DropdownButton<String>(
            //   style: TextStyle(color: Colors.white),
            //   hint: Text(_selectedIndex, style: TextStyle(color: Colors.black)),
            //   dropdownColor: Colors.black,
            //   value: _selectedIndex,
            //   items: <String>[
            //     'Baik Sekali',
            //     'Baik',
            //     'Kurang Baik',
            //     'Kurang Baik Sekali'
            //   ].map((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: new Text(value),
            //     );
            //   }).toList(),
            //   onChanged: (String statuBarang) {
            //     setState(() {
            //       _selectedIndex = statuBarang;
            //     });
            //   },
            // ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LimitedBox(
                  maxWidth: 150.0,
                  child: TextFormField(
                    controller: controllerKodeBarang,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Kode Barang",
                      labelStyle: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "isi kode barang",
                      hintStyle: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    onChanged: (String kodeBarang) {
                      getKodeBarang(kodeBarang);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LimitedBox(
                  maxWidth: 150.0,
                  child: TextFormField(
                    controller: controllerKeterangan,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Keterangan Barang",
                      labelStyle: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "isi status barang",
                      hintStyle: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    onChanged: (String keteranganBarang) {
                      getKeterangan(keteranganBarang);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LimitedBox(
                  maxWidth: 150.0,
                  child: TextFormField(
                    controller: controllerJmlBarang,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Jumlah assets",
                      labelStyle: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Masukkan jumlah assets",
                      hintStyle: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    onChanged: (String jmlBarang) {
                      getJmlBarang(jmlBarang);
                    },
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {},
              // child: Container(

              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      child: RaisedButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Text("Edit"),
                          textColor: Colors.white,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      Text("Yakin ingin mengedit barang ini?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ya'),
                                      onPressed: () {
                                        // createData();
                                        // database.createData(name, deskripsi);
                                        int thnBuatt =
                                            int.parse(controllerThnBuat.text);
                                        int jmlBarangg =
                                            int.parse(controllerJmlBarang.text);
                                        Map<String, dynamic> barang = {
                                          "namaBarang":
                                              controllerNamaBarang.text,
                                          "merk": controllerMerk.text,
                                          "thnBuat": thnBuatt,
                                          "statusBarang":
                                              controllerStatusBarang.text,
                                          "kodeBarang":
                                              controllerKodeBarang.text,
                                          "keterangan":
                                              controllerKeterangan.text,
                                          "jmlBarang": jmlBarangg
                                        };
                                        DocumentReference barangs =
                                            FirebaseFirestore.instance
                                                .collection('Barang')
                                                .doc(widget.kodeBarang);

                                        barangs.set(barang).whenComplete(() {
                                          print("$thnBuatt sudah dibuat");
                                        });

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Barang Inventaris berhasil diedit!!!'),
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
                          }),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ]))
        ])));
  }
}
