// import 'package:ds_master_detail/src/models/product_model.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final String documentId,
      namaBarang,
      merk,
      kodeBarang,
      statusBarang,
      keterangan;
  final int jmlBarang;
  const Detail(
      {Key key,
      this.documentId,
      this.namaBarang,
      this.merk,
      this.kodeBarang,
      this.statusBarang,
      this.keterangan,
      this.jmlBarang})
      : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Card(
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  "Nama Barang : " + widget.namaBarang,
                ),
                subtitle: Text(
                  "Merk Barang :" + widget.merk,
                ),
              ),
              Text(
                "Kode Barang :" + widget.kodeBarang,
              ),
              Text(
                "status Barang :" + widget.statusBarang,
              ),
              Text(
                "Jumlah Barang :" + widget.jmlBarang.toString(),
              ),
              Text(
                widget.jmlBarang.toString() +
                    " " +
                    widget.kodeBarang +
                    " " +
                    widget.statusBarang,
              ),
              Text(
                widget.keterangan,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class Detail extends StatelessWidget {
//   final String documentId,
//       namaBarang,
//       merk,
//       kodeBarang,
//       statusBarang,
//       keterangan;
//   final int jmlBarang;

//   const Detail({
//     Key key,
//     this.namaBarang,
//     this.merk,
//     // this.thnBuat,
//     this.kodeBarang,
//     this.statusBarang,
//     this.keterangan,
//     this.jmlBarang,
//     this.documentId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//       child: ListView(
//         children: [
//           ListTile(
//             contentPadding: EdgeInsets.zero,
//             title: Text(
//               widget.namaBarang,
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             subtitle: Text(
//               merk,
//             ),
//           ),
//           Text(
//             jmlBarang.toString() + " " + kodeBarang + " " + statusBarang,
//           ),
//           Text(
//             keterangan,
//           )
//         ],
//       ),
//     );
//   }
// }
