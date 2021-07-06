import 'dart:io';
import 'dart:ui';
import 'package:share/share.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
class Generate extends StatefulWidget {
  final String nama, documentId;
  Generate({
    @required this.documentId,
    @required this.nama,
  });
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  final GlobalKey globalKey = GlobalKey();
  String _inputErrorText;

  @override
  Widget build(BuildContext context) {
    String qrData = widget.documentId;
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 50, bottom: 20),
              child: Text(
                "QR Code",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
          RepaintBoundary(
            key: globalKey,
            child: GestureDetector(
              onTap: (){
                _capture();
              },
              child: QrImage(
                backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                data: qrData,
                
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 50, bottom: 20),
              child: Text(
                qrData,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
             
        ],
      ),
    );
  }
   Future<void> _capture() async {
     try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.shareFiles(['${tempDir.path}/image.png']);
    } catch (e) {
      print(e.toString());
    }

  }
}
