import 'dart:ui';
// import 'package:custom_dialog_flutter_demo/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            padding: EdgeInsets.all(8.0),
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        widget.text,
                        style: TextStyle(fontSize: 18),
                      )),
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
