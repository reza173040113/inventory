import 'package:flutter/material.dart';

class SymptomCard extends StatelessWidget {
  final String onpres;
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.onpres,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        // margin: ,
        height: 110,
        width: 120,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            isActive
                ? BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    color: Colors.black38,
                  )
                : BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 6,
                    color: Colors.black38,
                  ),
          ],
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Image.asset(image, height: 50, fit: BoxFit.fill),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
