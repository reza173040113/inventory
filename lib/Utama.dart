import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/generate.dart';

class Utama extends StatefulWidget {
  @override
  _UtamaState createState() => _UtamaState();
}

class _UtamaState extends State<Utama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("coba").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                width: 0,
                height: 0,
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];
                    Map<String, dynamic> task = documentSnapshot.data();
                    return Column(
                      children: [
                        Container(
                            child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(
                              task['nama'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kehadiran : ${task['nama']}"),
                                // Text("Tanggal :" +
                                //     dateString)
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.scanner),
                              onPressed: () async {
                                bool result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return Generate(
                                      documentId: documentSnapshot.id,
                                      nama: task['nama'],
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                        )),
                      ],
                    );
                  });
            }
          }),
    );
  }
}
