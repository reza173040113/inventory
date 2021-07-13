import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Utama.dart';
import 'package:inventory/addAsset.dart';
import 'package:inventory/generate.dart';
import 'package:inventory/login/MyApp.dart';
import 'package:inventory/scan.dart';
import 'package:inventory/widget/cardMenu.dart';
import 'package:inventory/widget/customDialog.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(new MaterialApp(
    title: "Halaman Utama",
    home: new HalamanUtama(),
  ));
}

class HalamanUtama extends StatefulWidget {
  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Halaman Utama"),
          backgroundColor: Color.fromARGB(237, 30, 60, 50),
          actions: [
            GestureDetector(
                onTap: () async {
                  await _firebaseAuth.signOut();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new MyApp()));
                },
                child: Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: size.height * 0.30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/6.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.27,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.all(3)),
                        // Text(
                        //   "* Silahkan usulkan campaign yang ingin diadakan *",
                        //   style: TextStyle(fontSize: 10),
                        // ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                // color: kExpandedColor,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return AddAsset();
                                        }));
                                      },
                                      child: SymptomCard(
                                        title: "Add Inventory",
                                        image: "assets/images/pencil.png",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                // color: kExpandedColor,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ScanPage();
                                        }));
                                      },
                                      child: SymptomCard(
                                        title: "Scan Inventory",
                                        image: "assets/images/scan.png",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: <Widget>[
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Barang")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot documentSnapshot =
                                            snapshot.data.docs[index];
                                        Map<String, dynamic> task =
                                            documentSnapshot.data();
                                        return GestureDetector(
                                          child: InkWell(
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 2),
                                                child: Container(
                                                  child: SizedBox(
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      children: <Widget>[
                                                        Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Card(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                elevation: 5,
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return CustomDialogBox(
                                                                            namaBarang:
                                                                                task['namaBarang'],
                                                                            merk:
                                                                                task['merk'],
                                                                            thnBuat:
                                                                                task['thnBuat'],
                                                                            kodeBarang:
                                                                                task['kodeBarang'],
                                                                            statusBarang:
                                                                                task['statusBarang'],
                                                                            jmlBarang:
                                                                                task['jmlBarang'],
                                                                            keterangan:
                                                                                task['keterangan'],
                                                                            text:
                                                                                "Yes",
                                                                          );
                                                                        });
                                                                  },
                                                                  child:
                                                                      ListTile(
                                                                    title: Text(
                                                                      task[
                                                                          'namaBarang'],
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.brown),
                                                                    ),
                                                                    subtitle:
                                                                        Column(
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
                                                                    trailing:
                                                                        IconButton(
                                                                      icon: Image
                                                                          .asset(
                                                                        "assets/images/qrcode.png",
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        bool
                                                                            result =
                                                                            await Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(builder:
                                                                              (context) {
                                                                            return Generate(
                                                                              documentId: documentSnapshot.id,
                                                                              nama: task['namaBarang'],
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

                        // TextFormField(
                        //   minLines:
                        //       6, // any number you need (It works as the rows for the textarea)
                        //   keyboardType: TextInputType.multiline,
                        //   maxLines: null,
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        // bottomNavigationBar: bottomBar(),
        );
  }

  // Widget bottomBar() {
  //   return Container(
  //     padding: EdgeInsets.all(15),
  //     // margin: EdgeInsets.only(top: 30, bottom: 0),
  //     child: FutureBuilder(
  //       future: userModel.getUserInfo(),
  //       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //         return ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: 1,
  //             itemBuilder: (BuildContext context, int index) {
  //               return FadeAnimation(
  //                   2,
  //                   GestureDetector(
  //                     onTap: () {
  //                       // Navigator.of(context).push(new MaterialPageRoute(
  //                       //     builder: (BuildContext context) => new Transaksi()
  //                     },
  //                     child: Align(
  //                       alignment: Alignment.bottomCenter,
  //                       child: Container(
  //                         margin: EdgeInsets.symmetric(vertical: 5.0),
  //                         padding: EdgeInsets.symmetric(horizontal: 10),
  //                         height: 50,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10),
  //                             gradient: LinearGradient(colors: [
  //                               Color.fromARGB(237, 30, 60, 1),
  //                               Color.fromARGB(237, 30, 60, 50),
  //                             ])),
  //                         child: Center(
  //                           child: Text(
  //                             "Send",
  //                             style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ));
  //             });
  //       },
  //     ),
  //   );
  // }

}
