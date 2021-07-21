import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Controller/BarangController.dart';
import 'package:inventory/Controller/PeminjamanController.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:inventory/HalamanUtama.dart';
import 'package:inventory/widget/date_picker_widget.dart';
// import 'package:table_calendar/table_calendar.dart';

class Peminjaman extends StatefulWidget {
  // final String namaPeminjam, namaBarang;
  // final int jumlahPinjam;
  // final DateTime tglPinjam, tglPengembalian;

  // Peminjaman(
  //     {@required this.namaPeminjam,
  //     @required this.namaBarang,
  //     @required this.tglPinjam,
  //     @required this.tglPengembalian,
  //     @required this.jumlahPinjam});
  // final DateTime tglPinjam, tglPengembalian;
  final String documentId,
      // namaPeminjam,
      namaBarang,
      merk,
      kodeBarang,
      statusBarang,
      keterangan;
  final int jmlBarang, thnBuat;

  Peminjaman({
    @required this.documentId,
    // @required this.namaPeminjam,
    @required this.namaBarang,
    // @required this.tglPinjam,
    // @required this.tglPengembalian,
    // @required this.jumlahPinjam,
    @required this.merk,
    @required this.thnBuat,
    @required this.kodeBarang,
    @required this.statusBarang,
    @required this.keterangan,
    @required this.jmlBarang,
  });
  @override
  _PeminjamanState createState() => _PeminjamanState();
}

class _PeminjamanState extends State<Peminjaman> {
  // final initialDate = DateTime.now();
  //  final newDate;
  DateTime selectedDatePinjam = DateTime.now();
  DateTime selectedDatePengembalian = DateTime.now();

  String getTextPinjam() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(selectedDatePinjam);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  String getTextPengembalian() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(selectedDatePengembalian);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  Future<void> _selectDatePinjam(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDatePinjam,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDatePinjam)
      setState(() {
        selectedDatePinjam = picked;
        getTglPinjam(selectedDatePinjam);
        txt.text =
            DateFormat('MM/dd/yyyy').format(selectedDatePinjam).toString();
      });
  }

  Future<void> _selectedDatePengembalian(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDatePengembalian,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDatePengembalian)
      setState(() {
        selectedDatePengembalian = picked;
        getTglPengembaian(selectedDatePengembalian);
        txt2.text = DateFormat('MM/dd/yyyy')
            .format(selectedDatePengembalian)
            .toString();
      });
  }

  DateTime date;
  PeminjamanController pc = new PeminjamanController();
  BarangController bc = new BarangController();
  VoidCallback onClicked;
  String namaPeminjam, namaBarang;
  int jumlahPinjam;
  Timestamp tglPinjam, tglPengembalian;
  // DatePickerWidget datePinjam = new DatePickerWidget();
  TextEditingController controllerNamaPeminjam = TextEditingController();
  TextEditingController controllerNamaBarang = TextEditingController();
  TextEditingController controllerJumlahPinjam = TextEditingController();
  TextEditingController controllerTglPinjam = TextEditingController();
  TextEditingController controllerTglPengembalian = TextEditingController();
  var txt = TextEditingController();
  var txt2 = TextEditingController();

  getNamaPeminjam(namaPeminjam) {
    this.namaPeminjam = namaPeminjam;
  }

  getNamaBarang(namaBarang) {
    this.namaBarang = namaBarang;
  }

  getJumlahPinjam(jumlahPinjam) {
    this.jumlahPinjam = int.parse(jumlahPinjam);
  }

  getTglPinjam(tglPinjam) {
    this.tglPinjam = Timestamp.fromDate(tglPinjam);
  }

  getTglPengembaian(tglPengembalian) {
    this.tglPengembalian = Timestamp.fromDate(tglPengembalian);
  }

  @override
  void initState() {
    super.initState();
    controllerNamaBarang.text = widget.namaBarang.toString();
    // controllerTglPinjam.text = selectedDatePinjam.toString();
    // controllerTglPengembalian.text = selectedDatePengembalian.toString();
    // controllerMerk.text = widget.merk.toString();
    // controllerStatusBarang.text = widget.statusBarang.toString();
    // controllerKeterangan.text = widget.keterangan.toString();
    // controllerJmlBarang.text = widget.jmlBarang.toString();
    // controllerThnBuat.text = widget.thnBuat.toString();
    // controllerKodeBarang.text = widget.kodeBarang.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Halaman Peminjaman"),
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
                    controller: controllerNamaPeminjam,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Nama Peminjam",
                      labelStyle: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "isi nama peminjam",
                    ),
                    onChanged: (String namaPeminjam) {
                      getNamaPeminjam(namaPeminjam);
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
                    keyboardType: TextInputType.number,
                    controller: controllerJumlahPinjam,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Jumlah Pinjam",
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
                    onChanged: (String jumlah) {
                      getJumlahPinjam(jumlah);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                LimitedBox(
                  maxWidth: 150.0,
                  child: TextFormField(
                    controller: txt,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Tanggal Pinjam",
                      labelStyle: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "isi tanggal pinjam",
                      hintStyle: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    onChanged: (String tglPinjam) {
                      setState(() {
                        controller:
                        txt.text;
                        // selectedDatePinjam.toString();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  onPressed: () => _selectDatePinjam(context),
                  child: Text(getTextPinjam()),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                LimitedBox(
                  maxWidth: 150.0,
                  child: TextFormField(
                    controller: txt2,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Tanggal Pengembalian",
                      labelStyle: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "isi tanggal pengembalian",
                      hintStyle: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    onChanged: (String tglPinjam) {
                      setState(() {
                        controller:
                        txt2.text;
                        // controllerTglPengembalian.text =
                        //     selectedDatePengembalian.toString();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  onPressed: () => _selectedDatePengembalian(context),
                  child: Text(getTextPengembalian()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
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
                          child: Text("Pinjam"),
                          textColor: Colors.white,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      Text("Yakin ingin meminjam barang ini? "),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ya'),
                                      onPressed: () {
                                        // createData();
                                        // database.createData(name, deskripsi);
                                        int jumlahBarangTersisa =
                                            (widget.jmlBarang - jumlahPinjam);
                                        pc.pinjam(
                                            namaPeminjam,
                                            widget.namaBarang,
                                            tglPinjam,
                                            jumlahPinjam,
                                            tglPengembalian);
                                        bc.updateJmlBarang(
                                            widget.namaBarang,
                                            widget.merk,
                                            widget.statusBarang,
                                            widget.kodeBarang,
                                            widget.thnBuat,
                                            jumlahBarangTersisa,
                                            widget.keterangan);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Barang Inventaris berhasil dipinjam!!!' +
                                                        jumlahBarangTersisa
                                                            .toString()),
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
