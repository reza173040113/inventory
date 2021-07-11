import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Utama.dart';

class AddAsset extends StatefulWidget {
  @override
  _AddAssetState createState() => _AddAssetState();
}

class _AddAssetState extends State<AddAsset> {
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
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [],
          title: Text(
            "Add Inventory Page",
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
            child: DropdownButton<String>(
              style: TextStyle(color: Colors.white),
              hint: Text(_selectedIndex, style: TextStyle(color: Colors.black)),
              dropdownColor: Colors.black,
              value: _selectedIndex,
              items: <String>[
                'Baik Sekali',
                'Baik',
                'Kurang Baik',
                'Kurang Baik Sekali'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String statuBarang) {
                setState(() {
                  _selectedIndex = statuBarang;
                });
              },
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
                    controller: txt,
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
              onTap: () {
                // ctrl.updateCampaign(
                //     namaCampaign,
                //     deskripsi,
                //     kategori,
                //     danaTerkumpul,
                //     valuee,
                //     danaCampaign,
                //     tanggal,
                //     gambarCampaign,
                //     documentId);

                // ctrl.createDataDonasi(
                //     nomor, valuee, namaDonatur);
              },
              // child: Container(
              //   margin: const EdgeInsets.all(8.0),
              //   padding: const EdgeInsets.all(8.0),
              //   height: 55,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: Color(0xFF065125),
              //   ),
              //   child: Center(
              //     child: Text(
              //       "Save",
              //       style: TextStyle(
              //           color: Colors.white, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      child: RaisedButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Text("Tambah"),
                          textColor: Colors.white,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      Text("Yakin ingin menambah barang ini?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ya'),
                                      onPressed: () {
                                        // createData();
                                        // database.createData(name, deskripsi);
                                        Map<String, dynamic> barang = {
                                          "namaBarang": namaBarang,
                                          "merk": merk,
                                          "thnBuat": int.parse(thnBuat),
                                          "statusBarang": _selectedIndex,
                                          "kodeBarang": kodeBarang,
                                          "keterangan": keterangan,
                                          "jmlBarang": jmlBarang
                                        };
                                        CollectionReference barangs =
                                            FirebaseFirestore.instance
                                                .collection('Barang');

                                        barangs
                                            .doc(kodeBarang)
                                            .set(barang)
                                            .whenComplete(() {
                                          print("$namaBarang sudah dibuat");
                                        });

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Barang Inventaris berhasil ditambahkan!!!'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('Ok'),
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new Utama()));
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
