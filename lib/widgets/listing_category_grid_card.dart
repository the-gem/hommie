import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListingCategoryGridCard extends StatelessWidget {
  String categoryName;
  ListingCategoryGridCard(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {},
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
                  width: 140,
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
