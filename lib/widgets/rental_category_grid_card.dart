import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hommie/pages/listing_page.dart';

class RentalCategoryGridCard extends StatelessWidget {
  String categoryName;
  RentalCategoryGridCard(
    this.categoryName,
  );
  displayListingBasedOnInputs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListingPage(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => displayListingBasedOnInputs(context),
        child: Card(
          elevation: 10,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset("assets/svg/004-house-27.svg")),
                Container(
                  // height: 30,
                  width: 100,
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      categoryName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
