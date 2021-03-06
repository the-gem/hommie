import 'package:flutter/material.dart';
import 'package:hommie/pages/rental_full_page.dart';

class RentalListCard extends StatelessWidget {
  goToRentalFullPage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RentalFullPage()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToRentalFullPage(context),
      child: Container(
        width: 400,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Image.asset(
                "assets/images/logo.jpg",
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "20000 Kshs",
                  style: TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("King'ore Dr, Ruaka, Kiambu County"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.king_bed,
                          ),
                          Text("2")
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.bathtub,
                          ),
                          Text("1")
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.directions_car,
                          ),
                          Text("2")
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
